extern crate cc;

fn main() {
    let mut cfg = cc::Build::new();
    cfg.opt_level(0)
        .warnings(false)
        .debug(false)
        .file("src/rust_test_helpers.c")
        .compile("rust_test_helpers");
}
