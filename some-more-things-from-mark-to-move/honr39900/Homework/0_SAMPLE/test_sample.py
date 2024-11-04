"""
Unit Tests for Homework SAMPLE
"""

#Required Packages
import numpy as np
import pytest
exec(f"from {pytest.config.getoption('name')} import *")

#Problem 1
def test_problem_1():
    assert problem_1(1) == 2
    assert problem_1(2) == 3
    assert problem_1(3) == 4

#Problem 2
def test_problem_2():
    assert problem_2(["Ford", "BMW", "Volvo", "GM"]) == ["BMW", "Ford", "GM", "Volvo"]
    assert problem_2([0,3,1,5,6,2,5]) == [0, 1, 2, 3, 5, 5, 6]
    assert problem_2(["Tesla", "Apple", "Microsoft", "Dell", "Google"]) == ["Apple", "Dell", "Google", "Microsoft", "Tesla"]

#Problem 3
def test_problem_3():
    assert problem_3(3.14159265358979) == 3.142
    assert problem_3(7.17937876452) == 7.179
    assert problem_3(10.742309745) == 10.742