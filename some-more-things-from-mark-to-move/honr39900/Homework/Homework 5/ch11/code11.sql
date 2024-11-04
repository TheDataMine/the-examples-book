-- tag::code_count_geoms_union[] --
SELECT 
    city, 
    COUNT(city) AS num_records, 
    SUM(ST_NumGeometries(geom)) AS numpoly_before,
    ST_NumGeometries(ST_Multi(ST_Union(geom))) AS num_poly_after
FROM ch11.cities
GROUP BY city
HAVING COUNT(city) > 1;
-- end::code_count_geoms_union[] --

-- tag::code_union_one_per_city[] --
SELECT city, ST_Multi(
    ST_Union(geom))::geometry(multipolygon,2227) AS geom -- <1> 
INTO ch11.distinct_cities -- <2>
FROM ch11.cities
GROUP BY city, ST_SRID(geom);

ALTER TABLE ch11.distinct_cities 
ADD CONSTRAINT pk_distinct_cities 
PRIMARY KEY (city); -- <3>

CREATE INDEX idx_distinct_cities_geom 
    ON ch11.distinct_cities USING gist(geom); -- <4>
-- end::code_union_one_per_city[] --

-- tag::code_make_path_gps[] --
SELECT 
    DATE_TRUNC('minute',time) - -- <1>
        CAST(
            mod(
                CAST(DATE_PART('minute',time) AS integer),15
            ) ||' minutes' AS interval
        ) AS track_period, -- <1>
    MIN(time) AS t_start, 
    MAX(time) AS t_end, 
    ST_MakeLine(geom ORDER BY time) AS geom  -- <2>
INTO ch11.aussie_run
FROM ch11.aussie_track_points
GROUP BY track_period -- <3> 
HAVING COUNT(time) > 1; -- <4>

SELECT 
    CAST(track_period AS timestamp), -- <5>
    CAST(t_start AS timestamp) AS t_start,    
    CAST(t_end AS timestamp) AS t_end, 
    ST_NPoints(geom) AS np, 
    CAST(ST_Length(geom::geography) AS integer) AS dist_m, -- <6>
    (t_end - t_start) AS dur               
FROM ch11.aussie_run;  
-- end::code_make_path_gps[] --


-- tag::code_diff_symdiff[] --
SELECT 
    ST_Intersects(g1.geom1,g1.geom2) AS they_intersect, -- <1>
    GeometryType(
        ST_Difference(g1.geom1,g1.geom2) ) AS intersect_geom_type
FROM (
    SELECT ST_GeomFromText(
        'POLYGON((
            2 4.5,3 2.6,3 1.8,2 0,-1.5 2.2,
            0.056 3.222,-1.5 4.2,2 6.5,2 4.5
        ))'
    ) AS geom1, 
    ST_GeomFromText('LINESTRING(-0.62 5.84,-0.8 0.59)') AS geom2
) AS g1;

SELECT 
    ST_Intersects(g1.geom1,g1.geom2) AS they_intersect, -- <2>
    GeometryType(
        ST_Difference(g1.geom2,g1.geom1) ) AS intersect_geom_type
FROM (
    SELECT ST_GeomFromText(
        'POLYGON((
            2 4.5,3 2.6,3 1.8,2 0,-1.5 2.2,
            0.056 3.222,-1.5 4.2,2 6.5,2 4.5
        ))'
    ) AS geom1, 
    ST_GeomFromText('LINESTRING(-0.62 5.84,-0.8 0.59)') AS geom2) AS g1;

SELECT 
    ST_Intersects(g1.geom1,g1.geom2) AS they_intersect, -- <3>
    GeometryType(
        ST_SymDifference(g1.geom1,g1.geom2)
    ) AS intersect_geom_type
FROM (
    SELECT ST_GeomFromText(
        'POLYGON((
            2 4.5,3 2.6,3 1.8,2 0,-1.5 2.2,
            0.056 3.222,-1.5 4.2,2 6.5,2 4.5
        ))'
    ) AS geom1, 
    ST_GeomFromText('LINESTRING(-0.62 5.84,-0.8 0.59)') AS geom2) AS g1;
-- end::code_diff_symdiff[] --

-- tag::code_split_poly_line[] --
SELECT gd.path[1] AS index, gd.geom AS geom  -- <1>
FROM ( -- <2>
    SELECT 
        ST_GeomFromText(
            'POLYGON((
                2 4.5,3 2.6,3 1.8,2 0,-1.5 2.2,0.056 
                3.222,-1.5 4.2,2 6.5,2 4.5
            ))'
        ) AS geom1, 
        ST_GeomFromText('LINESTRING(-0.62 5.84,-0.8 0.59)') AS geom2
) AS g1,
  ST_Dump(ST_Split(g1.geom1, g1.geom2)) AS gd --<3>
-- end::code_split_poly_line[] --

-- tag::code_grid_states_old_way[] --
WITH 
    usext AS (
        SELECT 
            ST_SetSRID(CAST(ST_Extent(geom) AS geometry),
            2163) AS geom_ext, 60 AS x_gridcnt, 40 AS y_gridcnt
        FROM us.states -- <1>
    ),
    grid_dim AS (
        SELECT 
            (
                ST_XMax(geom_ext)-ST_XMin(geom_ext)
                ) / x_gridcnt AS g_width, 
            ST_XMin(geom_ext) AS xmin, ST_xmax(geom_ext) AS xmax,
            (
                ST_YMax(geom_ext)-ST_YMin(geom_ext)
                ) / y_gridcnt AS g_height,     
            ST_YMin(geom_ext) AS ymin, ST_YMax(geom_ext) AS ymax
        FROM usext                                    
    ), -- <2>
    grid AS (                    
        SELECT 
            x, y, 
            ST_MakeEnvelope(  
                xmin + (x - 1) * g_width, ymin + (y - 1) * g_height,  
                xmin + x * g_width, ymin + y * g_height,
                2163
            ) AS grid_geom -- <3> 
        FROM 
            (SELECT generate_series(1,x_gridcnt) FROM usext) AS x(x)    
            CROSS JOIN 
            (SELECT generate_series(1,y_gridcnt) FROM usext) AS y(y) 
            CROSS JOIN 
            grid_dim                                                 
    )   
SELECT 
    g.x, g.y, state, state_fips, 
    ST_Intersection(s.geom, grid_geom) AS geom -- <4> 
INTO ch11.grid_throwaway                    
FROM us.states AS s INNER JOIN grid AS g 
ON ST_Intersects(s.geom,g.grid_geom); 

CREATE INDEX idx_us_grid_throwaway_geom 
ON ch11.grid_throwaway 
USING gist(geom); -- <5>
-- end::code_grid_states_old_way[] --

-- tag::code_square_grid[] --
WITH bounds AS (
 	SELECT ST_SetSRID(ST_Extent(geom), ST_SRID(geom)) AS geom -- <1>
		FROM ch11.boroughs
	GROUP BY ST_SRID(geom)
 ),
 grid AS (SELECT g.i, g.j, g.geom   -- <2>
		  FROM bounds, ST_SquareGrid(10000,bounds.geom) AS g
		  )
 SELECT b.boroname, grid.i, grid.j,  
      CASE WHEN ST_Covers(b.geom,grid.geom) THEN grid.geom
      ELSE ST_Intersection(b.geom, grid.geom) END AS geom -- <3>
 INTO ch11.boroughs_square_grid -- <4>
 FROM ch11.boroughs AS b
 	INNER JOIN grid ON ST_Intersects(b.geom, grid.geom);
    
CREATE INDEX ix_boroughs_square_grid  -- <5>
 ON ch11.boroughs_square_grid
   USING gist(geom);
-- end::code_square_grid[] --
-- <1> Creates a bounding box geometry covering the extent of the boroughs
-- <2> Creates a square grid each square grid is of 10000 sq units (feet)
-- <3> Clips the boroughs by the squares
-- <4> Creates a new table to store the data
-- <5> Create spatial index on new table

-- tag::code_square_grid2[] --
 SELECT b.boroname, grid.i, grid.j, 
    CASE WHEN ST_Covers(b.geom,grid.geom) THEN grid.geom
      ELSE ST_Intersection(b.geom, grid.geom) END AS geom -- <1>
 INTO ch11.boroughs_square_grid2 -- <2>
 FROM ch11.boroughs AS b
 	INNER JOIN ST_SquareGrid(10000,b.geom) AS grid -- <3>
      ON ST_Intersects(b.geom, grid.geom);
    
CREATE INDEX ix_boroughs_square_grid2  -- <5>
 ON ch11.boroughs_square_grid
   USING gist(geom);
-- end::code_square_grid2[] --
-- <1> Creates a bounding box geometry covering the extent of the boroughs
-- <2> Creates a square grid each square grid is of 10000 sq units (feet)
-- <3> Clips the boroughs by the squares
-- <4> Creates a new table to store the data
-- <5> Create spatial index on new table

-- tag::code_hex_grid[] --
 SELECT grid.i, grid.j, grid.geom, 
    COUNT(DISTINCT b.boroname)::integer AS num_boros -- <1>
 FROM ch11.boroughs AS b
 	INNER JOIN ST_HexagonGrid(1000,b.geom) AS grid -- <2>
      ON ST_Intersects(b.geom, grid.geom) -- <3>
GROUP BY grid.geom, grid.i, grid.j;
-- end::code_hex_grid[] --
-- <1> Return just the grids and count of boros in each grid
-- <2> Produce a set of hexagons that covers the bounding box of the borough
-- <3> Clips the boroughs by hexagons of 1000 feet in width

-- tag::code_bisect[] --
WITH RECURSIVE
x (geom,env) AS (
    SELECT
        geom, ST_Envelope(geom) AS env, ST_Area(geom)/2 AS targ_area,
        1000 AS nit
    FROM ch11.boroughs
    WHERE boroname = 'Queens'
),
T (n,overlap) AS (
    VALUES (CAST(0 AS float), CAST(0 AS float))
    UNION ALL
    SELECT
        n+nit,
        ST_Area(ST_Intersection(geom,ST_Translate(env,n+nit,0)))
    FROM T CROSS JOIN x
    WHERE
        ST_Area(ST_Intersection(geom,ST_Translate(env,n+nit,0)))
        >
        x.targ_area
),
bi(n) AS (SELECT n FROM T ORDER BY n DESC LIMIT 1)
SELECT
    bi.n,
    ST_Difference(geom,ST_Translate(x.env, n,0)) AS geom_part1,
    ST_Intersection(geom,ST_Translate(x.env, n,0)) AS geom_part2
FROM bi CROSS JOIN x;    
-- end::code_bisect[] --

-- tag::code_quadsect[] --
SELECT bucket, geom, ST_Area(geom) AS the_area
FROM utility.upgis_slicegeometry(
    (SELECT geom FROM ch11.boroughs WHERE boroname = 'Queens'), 
    4
) AS x;
-- end::code_quadsect[] --

-- tag::code_upgis_slicegeometry[] --
CREATE OR REPLACE FUNCTION 
    utility.upgis_slicegeometry(
        ageom geometry,numsections integer, 
        OUT bucket integer, OUT geom geometry)
RETURNS SETOF record AS
$$

WITH RECURSIVE
    
ref (geom,the_box,targ_area,x_mov,y_mov,  --  <1>
    x_length,y_length,xmin,ymin) AS ( 
    SELECT 
        geom, 
        ST_MakeEnvelope(
            xmin, ymin, 
            xmin + CAST(x_length/ngrid_xy AS integer), 
            ymin + CAST(y_length/ngrid_xy AS integer), 
            ST_SRID(s.geom)
        ) AS the_box, 
        ST_Area(geom)/$2 AS targ_area, 
        CAST(x_length/ngrid_xy AS integer) AS x_mov,  
        CAST(y_length/ngrid_xy AS integer) y_mov, 
        s.x_length, s.y_length, xmin, ymin        
    FROM (
        SELECT 
            $1 AS geom, ST_XMin($1) AS xmin, ST_YMin($1) AS ymin, 
            ST_XMax($1) - ST_XMin($1) AS x_length, 
            ST_YMax($1) - ST_YMin($1) AS y_length, 
            15*$2 AS ngrid_xy) AS s                   
    ),                                                         

X(x) AS ( -- <2>
    VALUES (CAST(0 AS float))
    UNION ALL                                         
    SELECT x + ref.x_mov FROM X CROSS JOIN ref WHERE x <  ref.x_length
),              
       
       
Y(y) AS ( 
    VALUES (CAST(0 AS float))       
    UNION ALL         
    SELECT y + ref.y_mov FROM Y CROSS JOIN ref WHERE y < ref.y_length
),        
   
diced AS (  -- <3>
    SELECT ROW_NUMBER() OVER(ORDER BY x,y) AS row_num, g.x, g.y, g.geom
    FROM (
        SELECT 
            x, y, 
            ST_Intersection(ref.geom,
                ST_Translate(ref.the_box,x,y)) AS geom
        FROM x CROSS JOIN y CROSS JOIN ref        
        WHERE ST_Intersects(ref.geom, ST_Translate(ref.the_box,x,y))
    ) AS g                                    
),                                                    

T (bucket, row_num, geom, total_area, targ_area, 
 remaining_area) AS ( -- <4> 
      SELECT 
        1 AS bucket, row_num, diced.geom, 
        ST_Area(diced.geom) AS total_area,  
        ref.targ_area, 
        ST_Area(ref.geom) - ST_Area(diced.geom) AS remaining_area
    FROM diced CROSS JOIN ref 
    WHERE diced.row_num = 1            
    UNION ALL    
    SELECT 
        CASE 
            WHEN 
                T2.total_area + ST_Area(diced.geom) < T2.targ_area 
                OR 
                T2.remaining_area < T2.targ_area/4 
            THEN 
                T2.bucket 
            ELSE T2.bucket + 1 END AS bucket, 
        diced.row_num, 
        diced.geom,                            
        CASE 
            WHEN T2.total_area + ST_Area(diced.geom) < T2.targ_area 
            THEN T2.total_area + ST_Area(diced.geom) 
            ELSE ST_Area(diced.geom) 
        END AS total_area, 
        T2.targ_area, 
        T2.remaining_area - ST_Area(diced.geom) AS remaining_area
    FROM 
        diced INNER JOIN 
        (SELECT * FROM T ORDER BY row_num DESC LIMIT 1) AS T2
    ON diced.row_num = T2.row_num + 1 
)
    
SELECT bucket, ST_Union(geom) AS geom  -- <5>
    FROM T GROUP BY T.bucket, T.targ_area  

$$
LANGUAGE 'sql' IMMUTABLE;
-- end::code_upgis_slicegeometry[] --

-- tag::code_subdivide_1[] --
SELECT row_number() OVER() AS bucket,x.geom, 
  ST_Area(x.geom) AS area, 
  ST_NPoints(x.geom) AS npoints,
  (ref.npoints/4)::integer As max_vertices
FROM (SELECT geom,  -- <1>
        ST_NPoints(geom) AS npoints
	  FROM ch11.boroughs WHERE boroname = 'Queens') AS ref
	     , LATERAL ST_Subdivide(ref.geom,
                  (ref.npoints/4)::integer -- <2> 
                  ) AS x(geom) ;
-- end::code_subdivide_1[] --

-- tag::code_subdivide_2[] --
SELECT row_number() OVER() AS bucket,x.geom, 
  ST_Area(x.geom) AS area, 
  ST_NPoints(x.geom) AS npoints,
  (ref.npoints/4)::integer As max_vertices
FROM (SELECT ST_Segmentize(geom, 10) AS geom,  -- <1>
        ST_NPoints(ST_Segmentize(geom, 10)) AS npoints
	  FROM ch11.boroughs WHERE boroname = 'Queens') AS ref
	     , LATERAL ST_Subdivide(ref.geom,
                  (ref.npoints/4)::integer -- <2> 
                  ) AS x(geom) ;
-- end::code_subdivide_2[] --


-- tag::code_upgis_shardgeometry[] --
CREATE OR REPLACE FUNCTION utility.upgis_shardgeometry(
	ageom geometry,
	numsections integer)
    RETURNS TABLE(bucket integer, geom geometry) 
    LANGUAGE sql
    COST 1000
    IMMUTABLE 
    ROWS 1000
AS $$
WITH ref AS (SELECT ST_Segmentize(ageom, 
                        ST_Perimeter(ageom)/( numsections*10000 ) ) AS geom,
                    ST_Area(ageom) AS tot_area
              )
  , a AS (SELECT row_number() OVER(ORDER BY sd.geom) AS sbucket,
              sd.geom, ref.tot_area
           FROM ref, 
            LATERAL ST_Subdivide( ref.geom  , 
                    greatest( (ST_NPoints(ref.geom)/(numsections*12) )::integer, 8) ) AS sd(geom)
          )
    , b AS (SELECT sbucket, a.geom, 
            ceiling((SUM( ST_Area(a.geom) ) OVER(ORDER BY sbucket))*numsections/a.tot_area)::integer AS new_bucket
      FROM a )
  SELECT b.new_bucket AS bucket, ST_Union(b.geom) AS geom
    FROM b
	GROUP BY b.new_bucket;
$$;
-- end::code_upgis_shardgeometry[] --

-- tag::code_segmentize_geog[] --
SELECT 
	ST_NPoints(geog::geometry) AS np_before,
	ST_NPoints(ST_Segmentize(geog,10000)::geometry) AS np_after
FROM ST_GeogFromText(
	'LINESTRING(-117.16 32.72,-71.06 42.35,3.3974 6.449,120.96 23.70)'
) AS geog;
-- end::code_segmentize_geog[] --

-- tag::code_subdivide_geog[] --
SELECT 
	sd.geom::geography,
	ST_NPoints(sd.geom) AS np_after
FROM ST_GeogFromText(
	'LINESTRING(-117.16 32.72,-71.06 42.35,3.3974 6.449,120.96 23.70)'
) AS geog, 
  LATERAL ST_Subdivide( ST_Segmentize(geog,10000)::geometry, 
                  3585/8) AS sd(geom);
-- end::code_subdivide_geog[] --

-- tag::code_two_point_line_old_way[] --
SELECT 
	ogc_fid, n AS pt_id, (sl.g).path[1] AS nline, 
    ST_MakeLine( -- <1>
		ST_PointN((sl.g).geom,n),
		ST_PointN((sl.g).geom,n+1)
	) AS geom 
FROM 
	(SELECT ogc_fid, ST_Dump(geom) AS g -- <2>
	    FROM ch11.aussie_tracks) AS sl 
	CROSS JOIN 
	generate_series(1,10000) AS n -- <3>
WHERE n < ST_NPoints((sl.g).geom) -- <4>
ORDER by ogc_fid, nline, pt_id;
-- end::code_two_point_line_old_way[] --

-- tag::code_two_point_line_lateral[] --
SELECT ogc_fid, n AS pt_id,(sl.g).path[1] AS nline,
	ST_MakeLine(   -- <1>
		ST_PointN((sl.g).geom,n),
		ST_PointN((sl.g).geom,n + 1)
	) AS geom
FROM 
	(SELECT ogc_fid, ST_Dump(geom) AS g -- <2>
      FROM ch11.aussie_tracks) AS sl
	CROSS JOIN LATERAL    
	generate_series(1,ST_NPoints((sl.g).geom) -  1) AS n -- <3>
ORDER by ogc_fid, nline, pt_id;
-- end::code_two_point_line_lateral[] --

-- tag::code_two_point_line_window[] --
WITH nl AS (SELECT
     ogc_fid, (sl.g).path[1] As nline, 
      (sl.g).path[2] AS pt_id,
     ST_MakeLine( -- <1>
          lag( (sl.g).geom )
              OVER(PARTITION BY sl.ogc_fid, (sl.g).path[1] 
                    ORDER BY (sl.g).path[2]  ), -- <2>
          (sl.g).geom 
      ) AS geom
FROM
(SELECT ogc_fid, ST_DumpPoints(geom) AS g -- <3>
FROM ch11.aussie_tracks) AS sl
ORDER BY ogc_fid, nline, pt_id)
SELECT *
FROM nl
WHERE pt_id > 1;
-- end::code_two_point_line_window[] --

-- tag::code_upgis_cutlineatpoints[] --
CREATE OR REPLACE FUNCTION ch11.upgis_cutlineatpoints(
	param_mlgeom geometry, 
	param_mpgeom geometry, 
	param_tol double precision
)
RETURNS geometry AS
$$
DECLARE
    var_resultgeom geometry;
    var_sline geometry;
    var_eline geometry;
    var_perc_line double precision;
    var_refgeom geometry;
    var_pset geometry[] :=  -- <1>
		ARRAY(SELECT geom FROM ST_Dump(param_mpgeom));             
    var_lset geometry[] := 
		ARRAY(SELECT geom FROM ST_Dump(param_mlgeom));  
BEGIN

FOR i in 1 .. array_upper(var_pset,1) LOOP -- <2>
	FOR j in 1 .. array_upper(var_lset,1) LOOP -- <3>
		IF 
			ST_DWithin(var_lset[j],var_pset[i],param_tol) AND -- <4>
			NOT ST_Intersects(ST_Boundary(var_lset[j]),var_pset[i])
		THEN                                 -- <5>
			IF ST_NumGeometries(ST_Multi(var_lset[j])) = 1 THEN 
				var_perc_line := 
				ST_LineLocatePoint(var_lset[j],var_pset[i]);
				IF var_perc_line BETWEEN 0.0001 and 0.9999 THEN
					var_sline := 
						ST_LineSubstring(var_lset[j],0,var_perc_line);
					var_eline := 
						ST_LineSubstring(var_lset[j],var_perc_line,1);
					var_eline := 
						ST_SetPoint(var_eline,0,ST_EndPoint(var_sline));
					var_lset[j] := ST_Collect(var_sline,var_eline);
				END IF;
			ELSE
				var_lset[j] :=   -- <6>
					upgis_cutlineatpoints(var_lset[j],var_pset[i]);
			END IF;
		END IF;
	END LOOP;
END LOOP;
  
RETURN ST_Union(var_lset);

END;
$$
LANGUAGE 'plpgsql' IMMUTABLE STRICT PARALLEL SAFE;
-- end::code_upgis_cutlineatpoints[] --

-- tag::code_cutlinatpoints_use[] --
SELECT 
	gid, S.geom AS orig_geom, 
	(ST_Dump(
	    ch11.upgis_cutlineatpoints(S.geom, X.the_pt, 100 )
	    )
	 ).geom AS changed_geom
FROM 
	ch11.stclines_streets AS S 
	CROSS JOIN
    (SELECT ST_SetSRID(ST_Point(6011200,2113500),2227) AS the_pt) AS X
WHERE ST_DWithin(s.geom,X.the_pt,100);
-- end::code_cutlinatpoints_use[] --

-- tag::code_hex_scaling[] --
SELECT 
    xfactor, yfactor, zfactor
	ST_Scale(hex.geom, xfactor, yfactor) AS scaled_geometry
    ST_Scale(hex.geom, ST_MakePoint(xfactor,yfactor, zfactor) ) AS scaled_using_pfactor
FROM 
    (
        SELECT ST_GeomFromText(
            'POLYGON((0 0,64 64,64 128,0 192, -64 128,-64 64,0 0))' --  <1>
        ) AS geom
    ) AS hex 
    CROSS JOIN 
    (SELECT x*0.5 AS xfactor FROM generate_series(1,4) AS x) AS xf 
    CROSS JOIN
    (SELECT y*0.5 AS yfactor FROM generate_series(1,4) AS y) AS yf -- <2>
    CROSS JOIN
    (SELECT z*0.5 AS zfactor FROM generate_series(0,1) AS z) AS zf; -- <3>
-- end::code_hex_scaling[] --

-- <1> Original hexagon
-- <2> Scaling values

-- tag::code_scaling_origin[] --
SELECT xfactor, yfactor, 
        ST_Scale(hex.geom, ST_MakePoint(xfactor, yfactor), ST_Centroid(hex.geom) ) AS scaled_geometry
FROM
	(
        SELECT ST_GeomFromText(
            'POLYGON((0 0,64 64,64 128,0 192,-64 128, -64 64,0 0))'
        ) AS geom
    ) AS hex 
    CROSS JOIN 
	(SELECT x*0.5 AS xfactor FROM generate_series(1,4) AS x) AS xf 
    CROSS JOIN 
	(SELECT y*0.5 AS yfactor FROM generate_series(1,4) AS y) AS yf;
-- end::code_scaling_origin[] --


-- tag::code_scaling_translating[] --
SELECT xfactor, yfactor, 
    ST_Translate(
        ST_Scale(hex.geom, xfactor, yfactor),
        ST_X(ST_Centroid(geom))*(1 - xfactor),
        ST_Y(ST_Centroid(geom))*(1 - yfactor) 
    ) AS scaled_geometry
FROM
	(
        SELECT ST_GeomFromText(
            'POLYGON((0 0,64 64,64 128,0 192,-64 128, -64 64,0 0))'
        ) AS geom
    ) AS hex 
    CROSS JOIN 
	(SELECT x*0.5 AS xfactor FROM generate_series(1,4) AS x) AS xf 
    CROSS JOIN 
	(SELECT y*0.5 AS yfactor FROM generate_series(1,4) AS y) AS yf;
-- end::code_scaling_translating[] --

-- rotate about centroid --
-- tag::code_rotate_hex_centroid[] --
SELECT 
    rotrad/pi()*180 AS deg, 
    ST_Rotate(hex.geom,rotrad, 
    ST_Centroid(hex.geom)) AS rotated_geometry
FROM 
    (
        SELECT ST_GeomFromText(
            'POLYGON((0 0,64 64,64 128,0 192,-64 128,-64 64,0 0))'
        ) AS geom
    ) AS hex
    CROSS JOIN 
    (
        SELECT 2*pi()*x*45.0/360 AS rotrad 
            FROM generate_series(0,6) AS x
    ) AS xf;
-- end::code_rotate_hex_centroid[] --

-- tag::code_st_collect_geog[] --
SELECT somefield, ST_Collect(geog::geometry)::geography AS geog 
FROM sometable 
GROUP BY somefield;
-- end::code_st_collect_geog[] --

-- tag::code_ugeog_simplifypreservetopology[] --
CREATE OR REPLACE FUNCTION 
    ugeog_SimplifyPreserveTopology(geography, double precision)
RETURNS geography AS
$$
SELECT 
    geography(
        ST_Transform(
            ST_SimplifyPreserveTopology(
                ST_Transform(geometry($1),_ST_BestSRID($1,$1)), -- <1> 
                $2
            ),
        4326)
    )
$$
LANGUAGE sql IMMUTABLE STRICT PARALLEL SAFE -- <2>
COST 300;
-- end::code_ugeog_simplifypreservetopology[] --