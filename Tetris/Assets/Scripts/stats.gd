extends Node

var current_score: int = 0

func calc_score(lines_cleared: int) -> int:
    var score = 0

    if lines_cleared > 1:
       score = (lines_cleared * 1.2) * 100

    else:
        score = 100

    return score

func reset():
    current_score = 0