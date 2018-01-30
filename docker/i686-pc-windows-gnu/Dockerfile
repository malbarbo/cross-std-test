FROM japaric/i686-pc-windows-gnu

COPY windows-entry.sh /
COPY wine-run.sh /
ENTRYPOINT ["/windows-entry.sh", "i686"]

ENV CARGO_TARGET_I686_PC_WINDOWS_GNU_RUNNER=/wine-run.sh
