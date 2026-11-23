#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
extern int yyparse(void);
extern void init_body(void);
extern void write_output(FILE *out);
extern int stat_three(void);
extern int stat_quad(void);
extern int stat_vars(void);

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <input.qc> <output.c>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) { perror(argv[1]); return 1; }

    init_body();
    if (yyparse() != 0) {
        fprintf(stderr, "Compilation failed.\n");
        fclose(yyin);
        return 1;
    }
    fclose(yyin);

    FILE *out = fopen(argv[2], "w");
    if (!out) { perror(argv[2]); return 1; }
    write_output(out);
    fclose(out);

    printf("QuadC: %s -> %s  (three-operand: %d, quadruple: %d, memory cells: %d)\n",
           argv[1], argv[2], stat_three(), stat_quad(), stat_vars());
    return 0;
}
