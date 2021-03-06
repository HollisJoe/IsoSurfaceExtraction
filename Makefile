TARGET=IsoSurfaceExtraction
SOURCE=IsoSurfaceExtraction.cpp

CFLAGS += -fopenmp -Wno-deprecated
LFLAGS += -lgomp

CFLAGS_DEBUG = -DDEBUG -g3 -std=c++11
LFLAGS_DEBUG =

CFLAGS_RELEASE = -O3 -DRELEASE -funroll-loops -ffast-math -std=c++11
LFLAGS_RELEASE = -O3 

SRC = Src/
BIN = Bin/Linux/
INCLUDE = /usr/include/ -I./

CC=gcc
CXX=g++
MD=mkdir

OBJECTS=$(addprefix $(BIN), $(addsuffix .o, $(basename $(SOURCE))))


all: CFLAGS += $(CFLAGS_RELEASE)
all: LFLAGS += $(LFLAGS_RELEASE)
all: $(BIN)
all: $(BIN)$(TARGET)

debug: CFLAGS += $(CFLAGS_DEBUG)
debug: LFLAGS += $(LFLAGS_DEBUG)
debug: $(BIN)
debug: $(BIN)$(TARGET)

clean:
	rm -f $(BIN)$(TARGET)
	rm -f $(OBJECTS)

$(BIN):
	$(MD) -p $(BIN)

$(BIN)$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LFLAGS)

$(BIN)%.o: $(SRC)%.c
	mkdir -p $(BIN)
	$(CC) -c -o $@ $(CFLAGS) -I$(INCLUDE) $<

$(BIN)%.o: $(SRC)%.cpp
	mkdir -p $(BIN)
	$(CXX) -c -o $@ $(CFLAGS) -I$(INCLUDE) $<

