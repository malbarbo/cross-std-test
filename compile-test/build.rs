extern crate cc;

use std::env;

fn main() {
    let mut cfg = cc::Build::new();
    if let Some(target) = env::var("COMPILE_TEST_TARGET").ok() {
        cfg.target(&*target)
            .cargo_metadata(false);
        let out = env::var_os("OUT_DIR").unwrap().into_string().unwrap();
        println!(
            "cargo:rustc-link-search=native={}", out);
        println!(
            "cargo:rustc-env=LD_LIBRARY_PATH=/rust/lib/rustlib/{}/lib/:{}", target, out);
    }
    cfg.opt_level(0)
        .warnings(false)
        .debug(false)
        .file("src/rust_test_helpers.c")
        .compile("rust_test_helpers");
}
