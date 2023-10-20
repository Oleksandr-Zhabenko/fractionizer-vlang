module main

import os {input}
import unitfractionsdecomposition2 as uf2

fn main() {
	// read text from stdin
	num1 := input('Enter integer number that shows a sign of error: ')
	println('Hello, ${num1}!')
        num2 := input('Enter f64 number that should be decomposed: ')
        println('Hello, ${num2}!')
        sol1, sol2 := uf2.set_of_solutions_g_min(num1.int(), num2.f64())
        println('Solution is: ${sol1} and ${sol2}')
}


