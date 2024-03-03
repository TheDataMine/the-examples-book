 .vimeo-wrapper {
        max-width: 980px;
        position: relative;
        margin: 0 auto;
        border: 1px solid green;
    }

    .vimeo-standard {
        float: left;
        height: 300px;
        width: 47%;
        border: 1px solid #000;
        margin: 10px;
	display:inline-block;
    }

    iframe {
        width: 40%;
        height: 40%;
    }


    @media (max-width:200px) {

        .vimeo-standard {
            float: none;
            width: 40%;
            margin: 0 auto;
            padding-bottom: 10px;
        }
    }

    .clearfix:before,
    .clearfix:after {
        content: " "; /* 1 */
        display: table; /* 2 */
    }

    .clearfix:after {
        clear: both;
    }


