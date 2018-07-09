/*
* Copyright (c) 2018 Caveware Digital (https://caveware.digital)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Josef Frank <josef@caveware.digital>
*/

using Gtk;

/**
 * NukeApp
 * ---
 * Entry point for the Nuke microwave cooking time conversion app.
 */
public class NukeApp : Gtk.Application {
    private bool change_lock;
    private WattageRow input;
    private WattageRow output;

    public NukeApp () {
        Object (
            application_id: "com.github.caveware.nuke",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        // Create the application window
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.border_width = 5;
        main_window.set_resizable (false);
        main_window.title = "Nuke";

        // Create wattage rows
        input = new WattageRow (_("Given wattage:"), 1000);
        output = new WattageRow (_("Your wattage:"), 700);

        // Connect to updates of rows
        change_lock = false;
        input.duration_changed.connect (update_output);
        input.wattage_changed.connect (update_output);
        output.duration_changed.connect (update_input);
        output.wattage_changed.connect (update_output);

        // Create a new grid with our wattage rows
        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.set_row_spacing (5);
        grid.add (input);
        grid.add (output);

        // Add grid to window and show
        main_window.add (grid);
        main_window.show_all ();

        // Initial state setup
        input.time = 90;
    }

    private void update_input () {
        if (!change_lock) {
            change_lock = true;
            input.time = convert (output.wattage, input.wattage, output.time);
            change_lock = false;
        }
    }

    private void update_output () {
        if (!change_lock) {
            change_lock = true;
            output.time = convert (input.wattage, output.wattage, input.time);
            change_lock = false;
        }
    }

    public static int main (string[] args) {
        var app = new NukeApp ();
        return app.run (args);
    }

    /** Converts a time from one wattage to another */
    protected int convert (float from, float to, float time) {
        return (int)Math.ceil (time * from / to);
    }
}
