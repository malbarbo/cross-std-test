FROM japaric/x86_64-pc-windows-gnu

COPY windows-entry.sh /
COPY wine-run.sh /
ENTRYPOINT ["/windows-entry.sh", "x86_64"]

ENV CARGO_TARGET_X86_64_PC_WINDOWS_GNU_RUNNER=/wine-run.sh
