TGT       = chat
TST       = $(TGT).t
OBJS      = $(patsubst %.cc,.obj/%.o,$(filter-out $(TST).cc, $(wildcard *.cc)))
OBJS     += .obj/chat.o
TSTOBJS   = $(patsubst %.cc,.obj/%.o,$(filter-out main.cc, $(wildcard *.cc)))
CXX       = g++
CC        = g++
DEBUG     = -g
CXXFLAGS  = -Wall -std=gnu++0x -I. $(DEBUG) -pthread -lpthread -Wl,--no-as-needed
CXXFLAGS += -I/usr/include/fltk -L/usr/lib64/fltk -lfltk
TESTLIBS  = -lgtest

$(TGT): $(OBJS)
	fluid -c $(TGT).fl
	$(LINK.cc) $^ $(LOADLIBS) $(LDLIBS) -o $@

$(TST): $(TSTOBJS)
	$(LINK.cc) $^ $(LOADLIBS) $(TESTLIBS) -o $@

.obj/%.o: %.cc
	$(COMPILE.cc) $(OUTPUT_OPTION) $<

.obj/%.o: %.cxx
	$(COMPILE.cc) $(OUTPUT_OPTION) $<

%.cxx: %.fl
	fluid -c $<

main.o: main.cc $(TGT).fl

$(TGT).cxx: $(TGT).fl

$(TGT).h: $(TGT).fl

$(TST).o: $(TST).cc $(TGT).cxx $(TGT).h

clean:
	rm -f .obj/*.o *~ $(TGT) $(TST)

test: $(TST)
	./$(TST)
