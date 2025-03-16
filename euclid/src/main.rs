use std::{fmt::Display, mem, ops::SubAssign};

use clap::Parser;
use num::{signum, Num, Signed};

#[derive(Debug, Parser)]
struct Args {
    a: u64,
    b: u64,
}

#[derive(Debug, Clone, Copy)]
struct EuclidTerm<N> {
    value: N,
    a_multiplier: N,
    b_multiplier: N,
}

impl<N> SubAssign for EuclidTerm<N> where N: SubAssign {
    fn sub_assign(&mut self, rhs: Self) {
        self.value -= rhs.value;
        self.a_multiplier -= rhs.a_multiplier;
        self.b_multiplier -= rhs.b_multiplier;
    }
}

fn euclid<N>(a: N, b: N) -> (EuclidTerm<N>, EuclidTerm<N>, usize)
where
    N: Num + PartialOrd + SubAssign + Copy + Display + Signed,
{
    assert!(a >= N::zero() && b >= N::zero(), "Inputs should be natural numbers.");
    let mut x = EuclidTerm {
        value: a,
        a_multiplier: N::one(),
        b_multiplier: N::zero(),
    };
    let mut y = EuclidTerm {
        value: b,
        a_multiplier: N::zero(),
        b_multiplier: N::one(),
    };
    let mut steps = 0;
    while x.value != N::zero() {
        // Invariant:
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.a_multiplier * y.b_multiplier - y.a_multiplier * x.b_multiplier in {-1, 1}
        display2(a, b, &x, &y);
        println!();
        if x.value >= y.value {
        // x.value - y.value >= 0
        // x.value - y.value = (x.a_multiplier - y.a_multiplier) * a + (x.b_multiplier - y.b_multiplier)* b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // (x.a_multiplier - y.a_multiplier) * y.b_multiplier - y.a_multiplier * (x.b_multiplier - y.b_multiplier) in {-1, 1}
            x -= y;
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.a_multiplier * y.b_multiplier - y.a_multiplier * x.b_multiplier in {-1, 1}
            steps += 1;
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.a_multiplier * y.b_multiplier - y.a_multiplier * x.b_multiplier in {-1, 1}
        } else {
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.a_multiplier * x.b_multiplier - x.a_multiplier * y.b_multiplier in {-1, 1}

            mem::swap(&mut x, &mut y);
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.a_multiplier * y.b_multiplier - y.a_multiplier * x.b_multiplier in {-1, 1}
        }
        // x.value >= 0
        // x.value = x.a_multiplier * a + x.b_multiplier * b
        // y.value >= 0
        // y.value = y.a_multiplier * a + y.b_multiplier * b
        // x.a_multiplier * y.b_multiplier - y.a_multiplier * x.b_multiplier in {-1, 1}
    }
    (y,x, steps)
}

fn display<N>(a : N, b : N, result: &EuclidTerm<N>)
where
    N: Num + PartialOrd + Display,
{
    if result.a_multiplier > N::zero() {
        println!("{} = {}*{}{}*{}", result.value, result.a_multiplier, a, result.b_multiplier, b)
    } else {
        println!("{} = {}*{}{}*{}", result.value, result.b_multiplier, b, result.a_multiplier, a)
    }
}

fn display2<N>(a : N, b : N, x: &EuclidTerm<N>, y: &EuclidTerm<N>)
where
    N: Num + Copy + PartialOrd + Display + Signed,
{
    display(a, b, x);    
    display(a, b, y);
    println!("Crossproducts:\n\t
x.a_multiplier * y.b_multiplier: {}\n\t
x.b_multiplier * y.a_multiplier: {}\n\t
               Their difference:{}\n\t
         signum(x.a_multiplier): {}\n",
               x.a_multiplier * y.b_multiplier,
               x.b_multiplier * y.a_multiplier,
               x.a_multiplier * y.b_multiplier - x.b_multiplier * y.a_multiplier,
               signum(x.a_multiplier),
            );
}

fn main() {
    let args = Args::parse();
    let (a, b) = (args.a as i128, args.b as i128);
    let (result, zero, steps) = euclid(a, b);
    display2(a, b, &result, &zero);
    println!("\tobtained in {} steps", steps);
}
