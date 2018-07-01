all:
	$(error "Please use a specific command")

clean:
	rm -R build

# Linux commands

lin-build:
	cd build; make

lin-install:
	make lin-build; sudo make install

lin-setup:
	mkdir build; cmake -DCMAKE_INSTALL_PREFIX=/usr ../

lin-test:
	make lin-build; ./nuke

# Windows commands

win-build:
	valac --pkg gtk+-3.0 src/Main.vala src/DurationSelector.vala src/WattageRow.vala src/WattageSelector.vala -o ./build/Nuke

win-test:
	make clean; make win-setup; make win-build; ./build/Nuke

win-setup:
	mkdir build;