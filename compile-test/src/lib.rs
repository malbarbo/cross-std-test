extern crate compiletest_rs as compiletest;

#[cfg(test)]
mod tests {
    use compiletest;
    use std::env;
    use std::path::PathBuf;

    #[test]
    fn run_pass() {
        run("run-pass", "run-pass");
    }

    #[test]
    fn run_pass_failing() {
        run("run-fail", "run-pass-failing");
    }

    #[test]
    fn run_fail() {
        run("run-fail", "run-fail");
    }

    fn run(mode: &'static str, path: &'static str) {
        let mut config = compiletest::Config::default();
        config.mode = mode.parse().expect("Invalid mode");
        config.src_base = PathBuf::from(format!("tests/{}", path));
        config.filter = env::var("COMPILE_TEST_FILTER").ok();
        config.linker = env::var(format!("CC_{}", config.target.replace('-', "_"))).ok();
        config.runtool = env::var(format!(
            "CARGO_TARGET_{}_RUNNER",
            config.target.replace('-', "_").to_uppercase()
        )).ok();
        config.link_deps();
        compiletest::run_tests(&config);
    }
}
