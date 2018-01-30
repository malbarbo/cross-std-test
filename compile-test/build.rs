extern crate cc;

use std::env;

fn main() {
    let mut cfg = cc::Build::new();
    if let Some(target) = env::var("COMPILE_TEST_TARGET").ok() {
        cfg.target(&*target);
    }
    cfg.opt_level(0)
        .warnings(false)
        .debug(false)
        .file("src/rust_test_helpers.c")
        .cargo_metadata(false)
        .compile("rust_test_helpers");
    println!("cargo:rustc-link-search=native={}", env::var_os("OUT_DIR").unwrap().into_string().unwrap());
}
