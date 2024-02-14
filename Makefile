# Makefile for gameof1d
#
# Part of assignment 3 for 2024 PHY1610
#
CXX=g++
CXXFLAGS=-O0 -g  -march=native -Wall
OBJS=gameof1d.o fillcells.o updatecells.o outputcells.o
LDLIBS=-lCatch2Main -lCatch2 

all: gameof1d originalgameof1d

test: integrated_test run_fillcells_c2 run_outputcells_c2 run_updatecells_c2

run_fillcells_c2: fillcells_c2 
	./fillcells_c2 -s

fillcells_c2: fillcells_c2.o fillcells.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

fillcells_c2.o: fillcells_c2.cpp fillcells.h celltype.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

run_updatecells_c2: updatecells_c2 
	./updatecells_c2 -s

updatecells_c2: updatecells_c2.o updatecells.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

updatecells_c2.o: updatecells_c2.cpp updatecells.h celltype.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

run_outputcells_c2: outputcells_c2
	./outputcells_c2 -s

outputcells_c2: outputcells_c2.o outputcells.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

outputcells_c2.o: outputcells_c2.cpp outputcells.h celltype.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

integrated_test: originaltestoutput.txt testoutput.txt
	diff originaltestoutput.txt testoutput.txt

originaltestoutput.txt: originalgameof1d
	./originalgameof1d > originaltestoutput.txt

testoutput.txt: gameof1d
	./gameof1d > testoutput.txt

originalgameof1d: originalgameof1d.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

gameof1d: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

gameof1d.o: gameof1d.cpp fillcells.h updatecells.h outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $< 

fillcells.o: fillcells.cpp fillcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

updatecells.o: updatecells.cpp updatecells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

outputcells.o: outputcells.cpp outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

run: gameof1d
	./gameof1d

clean:
	$(RM) $(OBJS) fillcells_c2.o  outputcells_c2.o updatecells_c2.o

distclean: clean
	$(RM) fillcells_c2 gameof1d originalgameof1d outputcells_c2 updatecells_c2 originaltestoutput.txt testoutput.txt
