FROM cargo30.dev.caicloud.xyz/library/alpine:3.13-ncurses as BUILD

WORKDIR /sudoku

COPY . .

RUN make && cp sudoku.test puzzles.txt /tmp

CMD ["/bin/sh"]

FROM cargo30.dev.caicloud.xyz/library/alpine:3.13-ncurses

COPY --from=BUILD /tmp/sudoku.test /usr/local/bin

WORKDIR /sudoku
COPY --from=BUILD /tmp/puzzles.txt .

CMD ["/bin/sh", "-c", "while :; do cat puzzles.txt | sudoku.test; sleep 5; done"]
