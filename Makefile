CC      = gcc
FLEX    = flex
BISON   = bison
BUILD   = build
SRC     = src
EXAMPLE = example
OUTPUT  = output

all: quadc

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/parser.tab.c $(BUILD)/parser.tab.h: $(SRC)/parser.y | $(BUILD)
	$(BISON) -d -o $(BUILD)/parser.tab.c $(SRC)/parser.y

$(BUILD)/lex.yy.c: $(SRC)/lexer.l $(BUILD)/parser.tab.h | $(BUILD)
	$(FLEX) -o $(BUILD)/lex.yy.c $(SRC)/lexer.l

quadc: $(BUILD)/parser.tab.c $(BUILD)/lex.yy.c $(SRC)/main.c
	$(CC) -I$(BUILD) -o quadc $(BUILD)/parser.tab.c $(BUILD)/lex.yy.c $(SRC)/main.c

# compile every example to C, then build and run the generated C
run: quadc
	mkdir -p $(OUTPUT)
	@for f in $(EXAMPLE)/*.qc; do \
		n=$$(basename $$f .qc); \
		./quadc $$f $(OUTPUT)/$$n.c && \
		$(CC) -o $(OUTPUT)/$$n $(OUTPUT)/$$n.c && \
		echo "--- running $$n ---" && ./$(OUTPUT)/$$n; \
	done

clean:
	rm -rf $(BUILD) quadc $(OUTPUT)/*

.PHONY: all run clean
