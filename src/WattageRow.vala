/**
 * WattageRow
 * ---
 * Row containing some text, a wattage selector, and a value box.
 */
public class WattageRow : Gtk.Grid {
    private Gtk.Entry entry;
    private Gtk.Label label;
    private WattageSelector selector;
    
    /** Constructor */
    public WattageRow (string text, int wattage) {
        // Field to display label
        label = new Gtk.Label (text);
        label.xalign = 0;
        label.hexpand = true;
        add (label);

        // Field for selecting wattage
        selector = new WattageSelector ();
        selector.wattage = wattage;
        add (selector);

        // Field for entring in time
        entry = new Gtk.Entry ();
        add (entry);
        
        // Space the rows out a little
        set_column_spacing (5);
    }

    /** Controls the wattage */
    public int wattage {
        get { return selector.wattage; }
        set { selector.wattage = value; }
    }
}