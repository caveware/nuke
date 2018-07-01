/**
 * WattageRow
 * ---
 * Row containing some text, a wattage selector, and a value box.
 */
public class WattageRow : Gtk.Grid {
    private Gtk.Label label;
    private DurationSelector duration;
    private WattageSelector selector;
    public signal void duration_changed ();
    public signal void wattage_changed ();
    
    /** Constructor */
    public WattageRow (string text, int wattage) {
        // Field to display label
        label = new Gtk.Label (text);
        label.xalign = 0;
        label.hexpand = true;
        add (label);

        // Field for selecting wattage
        selector = new WattageSelector ();
        selector.changed.connect (() => wattage_changed ());
        selector.wattage = wattage;
        add (selector);

        // Field for entring in time
        duration = new DurationSelector ();
        duration.changed.connect (() => duration_changed ());
        add (duration);
        
        // Space the rows out a little
        set_column_spacing (5);
    }

    /** Controls the time */
    public int time {
        get { return duration.time; }
        set { duration.time = value; }
    }

    /** Controls the wattage */
    public int wattage {
        get { return selector.wattage; }
        set { selector.wattage = value; }
    }
}