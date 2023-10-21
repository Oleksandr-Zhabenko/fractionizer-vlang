module unitfractionsdecomposition2

import math
import math.stats as stat
import arrays {sum}

pub fn three_digits_k(k f64) f64 {
    return (math.round(k * 1000) / 1000.0)
}

pub type ErrorImpact = int

pub struct Tuple {
mut: 
    fst []f64
    snd f64 
}

pub struct TupleI {
mut: 
    fst []i64
    snd f64 
}

pub struct Tuple3 {
mut: 
    num int
    sol ?Tuple
    err f64
}

pub fn abs_err2frac(k f64, y f64) f64 {
    return (1.0/y + 1.0 / math.round(y/(k*y - 1.0)) - k)
}

pub fn err_impact(n ErrorImpact, x f64) f64 {
    if n > 0 { return math.trunc(x) }
    else if n < 0 { return math.ceil(x) }
    else { return math.round(x) }
}

pub fn abs_err2frac_i(n ErrorImpact, k f64, y f64) f64 {
    return (1.0/y + 1.0 / err_impact(n, y/(k*y - 1.0)) - k)
}

pub fn abs_err_u_decomp3_i(n ErrorImpact, ts []f64, k f64) f64 {
    match ts.len {
        3 { return 1.0/ts[0] + 1.0/math.ceil(ts[1]) + 1.0/err_impact(n, ts[2]) - k}
        2 { return 1.0/ts[0] + 1.0/err_impact(n,ts[1]) - k }
        1 { return 1.0/err_impact(n, ts[0]) - k }
        else {return -1.0 }
    }
}

pub fn abs_err_u_decomp3(ts []f64, k f64) f64 { return abs_err_u_decomp3_i(0,ts,k) }

pub fn elem_solution2_i(n ErrorImpact, y f64, k f64) bool {
    return (n == 0 || (n*(abs_err2frac_i(n, k, y)) >= 0))
}

pub fn elem_solution2(n int, y f64, k f64) bool {
    return  true
}

pub fn is_range_n(k f64) bool { return k >= 0.005 && k <= 0.9 }

pub fn is_range_n_pref(k f64) bool { return k >= 0.005 && k <= (2.0/3.0) }

pub fn set_of_solutions_g_min(n ErrorImpact, k f64) (f64, f64) {
    match true {
        is_range_n(k) { return set_of_solutions_g_min_1(n, k) }
        else { return 0, -1.0 }
    }
}

fn set_of_solutions_g_min_1(n int, k f64) (f64, f64) {
    j0 := 1.0 / k
    j1 := if math.ceil(j0) == j0 { math.ceil(1.0/k) + 1.0 } 
          else { math.ceil(1.0/k) }
    p0 := 2.0/k
    p1 := if math.trunc(p0) == p0 { math.trunc(2.0/k) - 1.0 }
          else { math.trunc(2.0/k) }
    p := int(p1)
    j := int(j1)
    if j == p { if elem_solution2_i(n,j1,k) { return j1, j1/(k*j1 - 1.0)}
                else {return 0.0, -1.0}}
    else { arr := []f64{len: math.abs(p-j+1), init: index + math.min(j1, p1)}
           mut y := -0.0001
           for i:=p-j; i >= 0; i -= 1 { 
               if elem_solution2_i(n, err_impact(n, arr[i]),k) && math.abs(abs_err2frac_i(n, k,arr[i])) < math.abs(abs_err2frac_i(n,k,y)) { y= arr[i] }
           }
           if math.abs(y + 0.0001)  < 0.000001 { return 0.0, 0.0 }
           else { return y, y/(k*y - 1.0) }
         }
}

pub fn set_of_solutions_g_min3(n ErrorImpact, noteq i64, k f64) (f64, f64) {
    match true {
        is_range_n(k) { return set_of_solutions_g_min_3(n, noteq, k) }
        else { return 0, -1.0 }
    }
}

fn set_of_solutions_g_min_3(n int, noteq i64, k f64) (f64, f64) {
    j0 := 1.0 / k
    j1 := if math.ceil(j0) == j0 { math.ceil(1.0/k) + 1.0 } 
          else { math.ceil(1.0/k) }
    p0 := 2.0/k
    p1 := if math.trunc(p0) == p0 { math.trunc(2.0/k) - 1.0 }
          else { math.trunc(2.0/k) }
    p := int(p1)
    j := int(j1)
    if j == p { if elem_solution2_i(n,j1,k) { return j1, j1/(k*j1 - 1.0)}
                else {return 0.0, -1.0}}
    else { mut arr := []f64{len: math.abs(p-j+1), init: index + math.min(j1, p1)}
           idx := arr.index(f64(noteq))
           if idx != -1 {arr.delete(idx)} 
           mut y := -0.0001
           for i:=p-j; i >= 0; i -= 1 { 
               if elem_solution2_i(n, err_impact(n, arr[i]),k) && math.abs(abs_err2frac_i(n, k,arr[i])) < math.abs(abs_err2frac_i(n,k,y)) { y= arr[i] }
           }
           if math.abs(y + 0.0001)  < 0.000001 { return 0.0, 0.0 }
           else { return y, y/(k*y - 1.0) }
         }
}

pub fn suitable2(k f64) (f64, f64) {
    return set_of_solutions_g_min(0, k)
}

pub fn suitable21_g(n ErrorImpact, k f64) ?Tuple {
    x, y := set_of_solutions_g_min(n, k)
    if math.abs(x) < 0.00001 { return none }
    else { return Tuple{[x, y], (1.0/x + 1.0/err_impact(n, y) - k)} }
}

//pub fn suitable21(k f64) ?([]f64, f64) {
//    return suitable21_g(0,k) // it returns compiler bug.
//}

pub fn suitable21(k f64) ?Tuple {
    return suitable21_g(0,k) 
}

pub fn suitable21_g_3(n ErrorImpact, noteq i64, k f64) ?Tuple {
    x, y := set_of_solutions_g_min_3(n, noteq, k)
    if math.abs(x) < 0.00001 { return none }
    else { return Tuple{[x, y], (1.0/x + 1.0/err_impact(n, y) - k)} }
}

pub fn check1_frac_decomp_g(n ErrorImpact, k f64) ?Tuple {
    if k >= 0.005 && k <= 0.501 { c := 1.0/k
                                  ec := err_impact(n, c)
                                  cs := [ec]
                                  return Tuple{cs, abs_err_u_decomp3_i(n, cs, k)} }
    else { return none }
}

pub fn check3_frac_decomp_partial_pg(n ErrorImpact, ns []i64, k f64) ?Tuple {
    if k >= 0.005 && k <= 1 { return check3_frac_decomp_partial_pg1(n, ns, k) }
    else { return none }
}

fn check3_frac_decomp_partial_pg1(n ErrorImpact, ns []i64, k f64) ?Tuple {
    upp := 2.0/3.0
    cl := math.ceil(1.0/k)
    tr := math.trunc(3.0/k)
    cli64 := i64(cl)
    tri64 := i64(tr)
    len1 :=  math.abs(int(tri64-cli64+1))
    arr := []f64{len: len1 + ns.len, init: if index < len1 { index + cli64 } else { ns[index-len1]} }
    lst2check := arr.map(k - 1.0/it).filter(it >= 0.005 && it <= upp)
    s2s := lst2check.map(suitable21_g(n, it)).filter(it!=none)
    if s2s.len == 0 { return none }
    else { snds := s2s.map(it?.snd)
           tuple := s2s[stat.min_index(snds)]
           a1 := tuple?.fst[0]
           b1 := tuple?.fst[1]
           err3 := tuple?.snd
           u1 := math.round(1.0/(k + err3 - (1.0/a1 + 1.0/err_impact(n, b1))))
           return Tuple{[u1,a1,err_impact(n,b1)], err3} }
}

pub fn check3_frac_decomp_partial_pg_3(n ErrorImpact, ns []i64, k f64) ?Tuple {
    if k >= 0.005 && k <= 1 { return check3_frac_decomp_partial_pg2(n, ns, k) }
    else { return none }
}

fn check3_frac_decomp_partial_pg2(n ErrorImpact, ns []i64, k f64) ?Tuple {
    upp := 2.0/3.0
    cl := math.ceil(1.0/k)
    tr := math.trunc(3.0/k)
    cli64 := i64(cl)
    tri64 := i64(tr)
    len1 :=  math.abs(int(tri64-cli64+1))
    arr := []f64{len: len1 + ns.len, init: if index < len1 { index + cli64 } else { ns[index-len1]} }
    lst2check := arr.map(k - 1.0/it).filter(it >= 0.005 && it <= upp)
    s2s := lst2check.map(suitable21_g_3(n, i64(math.round(1.0/(k - it))), it)).filter(it!=none)
    if s2s.len == 0 { return none }
    else { snds := s2s.map(it?.snd)
           tuple := s2s[stat.min_index(snds)]
           a1 := tuple?.fst[0]
           b1 := tuple?.fst[1]
           err3 := tuple?.snd
           u1 := math.round(1.0/(k + err3 - (1.0/a1 + 1.0/err_impact(n, b1))))
           return Tuple{[u1,a1,err_impact(n,b1)], err3} }
}

pub fn less_err_simple_decomp_pg(n ErrorImpact, ns []int, k f64) Tuple3 {
    mut soluts3 := [check1_frac_decomp_g(n, k), suitable21_g(n, k), check3_frac_decomp_partial_pg_3(n,ns.map(i64(it)),k)]
    s2s := soluts3.filter(it!=none)
    if s2s.len == 0 { return Tuple3{0, none, -1.0} }
    else { snds := s2s.map((it or {Tuple{[], -1.0}}).snd)
           p := s2s[stat.min_index(snds)]
           return Tuple3{(p or {Tuple{[],-1.0}}).fst.len, p, (p or {Tuple{[],-1.0}}).snd}
         }
}

pub fn less_err_denoms_pg(n ErrorImpact, ns []int, k f64) []i64 {
    tuple3 := less_err_simple_decomp_pg(n, ns, k)
    sol2 := tuple3.sol
    return (sol2 or {return []}).fst.map(i64(err_impact(n, it)))
}

pub fn check1_frac_decomp(k f64) ?Tuple {
    return check1_frac_decomp_g(0,k)
}

pub fn check3_frac_decomp_partial_g(n ErrorImpact, k f64) ?Tuple {
    return check3_frac_decomp_partial_pg(n, [], k)
}

pub fn check3_frac_decomp_partial(k f64) ?Tuple {
    return check3_frac_decomp_partial_g(0,k)
}

pub fn check3_frac_decomp_partial_p(ns []int, k f64) ?Tuple {
    return check3_frac_decomp_partial_pg(0,ns.map(i64(it)), k)
}

pub fn less_err_simple_decomp_p(ns []int, k f64) Tuple3 {
    return less_err_simple_decomp_pg(0, ns, k)
}

pub fn less_err_denoms_p(ns []int, k f64) []i64 {
    return less_err_denoms_pg(0, ns, k)
}

pub fn less_err_simple_decomp_4pg(n ErrorImpact, ns []int, k f64) TupleI {
    ints := less_err_denoms_pg(-1, ns, k)
    revs := ints.map(1.0/f64(it))
    s := arrays.sum[f64](revs) or { return TupleI{[], -1.0} }
    err := s - k
    reverr := 1.0 / math.abs(err)
    next := err_impact(n, reverr)
    err4 := err + 1.0 / next
    l := ints.len
    arr := []i64 {len: l + 1, init: if index < (l - 1) { ints[index] } else { i64(next) } }
    return TupleI{arr, err4}
} 

pub fn less_err_simple_decomp_5pg(n ErrorImpact, ns []int, k f64) TupleI {
    tuplei := less_err_simple_decomp_4pg(-1, ns, k)
    mut ints := tuplei.fst.clone()
    err4 := tuplei.snd
    reverr := 1.0/math.abs(err4)
    next := err_impact(n, reverr)
    err5 := err4 + 1.0/next
    ints << i64(math.round(next))
    return TupleI{ints, err5}
}

pub struct Tuple2I {
mut:
    fst i64
    snd i64
}

pub struct TupleEgypt {
mut:
    fst []Tuple2I
    err f64 
}

pub fn egyptian_fraction_decomposition(k f64) TupleEgypt {
    upp := 2.0/3.0
    if k <= 1.0 && k >= upp { tuple := less_err_simple_decomp_5pg(0, [], k - upp)
                              ks := tuple.fst
                              err := tuple.snd
                              l := ks.len
                              mut arr := []Tuple2I{len: l + 1, init: if index == 0 {Tuple2I{2,3}} else {Tuple2I{ 1, ks[index - 1] }}}
                              return TupleEgypt{arr, err}}
    else {   tuple := less_err_simple_decomp_5pg(0, [], k)
             ks := tuple.fst
             err := tuple.snd
             l := ks.len
             mut arr := []Tuple2I{len: l, init: Tuple2I{ 1, ks[index] }}
             return TupleEgypt{arr, err}}
}


