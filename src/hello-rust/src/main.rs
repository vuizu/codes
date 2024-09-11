use std::str::FromStr;

pub struct Person {
    pub name: String,
    pub aget: u8,
    pub watermelon: String,
}

#[allow(unused)]
fn main() {
    println!("Hello, world!");
    let res: i32 = {
        println!("hello");
        1
    };

    let st1: String = "123".to_string();
    let st2: &str = "123";
    println!("{:?}", i32::from_str(&st2));
    let lst = [1, 2, 3];

    let abc = (-4i32).abs();
    // let abc = (-4).abs();
    let bdc = i32::abs(-4);

    let dce = i32::pow(2, 4);
    let cdf = 2i32.pow(4);
}
