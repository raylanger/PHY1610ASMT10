# Makefile for gameoflife
#
# Starter code for assignment 10 for 2024 PHY1610
#
CXX=g++
CXXFLAGS=-O3 -g -march=native -Wall -fopenmp
OBJS=gameoflife.o fillcells.o updatecells.o outputcells.o
LDLIBS= -fopenmp -lCatch2Main -lCatch2

all: gameoflife

test: run_fillcells_c2 run_outputcells_c2 run_updatecells_c2

integrated_test: originaltestoutput.txt testoutput.txt
	diff originaltestoutput.txt testoutput.txt

originaltestoutput.txt: gameoflife0
	./gameoflife0 6 70 20 0.158 1 > originaltestoutput.txt 

testoutput.txt: gameoflife
	./gameoflife 6 70 20 0.158 1 > testoutput.txt

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

gameoflife: $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

gameoflife.o: gameoflife.cpp fillcells.h updatecells.h outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $< 

fillcells.o: fillcells.cpp fillcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

updatecells.o: updatecells_new.cpp updatecells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

outputcells.o: outputcells_new.cpp outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

gameoflife0: gameoflife0.o fillcells0.o updatecells0.o outputcells0.o
	$(CXX) $(LDFLAGS) -o $@ $^ $(LDLIBS)

gameoflife0.o: gameoflife.cpp fillcells.h updatecells.h outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $< 

fillcells0.o: fillcells.cpp fillcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

updatecells0.o: updatecells.cpp updatecells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

outputcells0.o: outputcells.cpp outputcells.h celltype.h
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

run: gameoflife
	./gameoflife

clean:
	$(RM) $(OBJS) fillcells_c2.o  outputcells_c2.o updatecells_c2.o 

distclean: clean
	$(RM) fillcells_c2 gameoflife outputcells_c2 updatecells_c2

cleantest:
	$(RM) originaltestoutput.txt testoutput.txt