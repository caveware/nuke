/**
 * WattageSelector
 * ---
 * Allows the user to select the wattage they would like to use.
 */
public class WattageSelector : Gtk.ComboBox {
    protected int column_id = 0;
    protected int min_wattage = 300;
    protected int max_wattage = 1400;
    protected int step = 25;

    /** Constructor */
    public WattageSelector () {
        // Create list of wattages
        Gtk.ListStore liststore = new Gtk.ListStore(1, typeof (string));
        for (int i = min_wattage; i <= max_wattage; i += step) {
            Gtk.TreeIter iter;
            liststore.append (out iter);
            liststore.set (iter, column_id, i.to_string() + "W");
        }
        set_model(liststore);

        // Render cells
        Gtk.CellRendererText cell = new Gtk.CellRendererText ();
        pack_start (cell, false);
        set_attributes (cell, "text", column_id);

        // Set the first wattage as active
        set_active (0);

        // Show 5 entries per line, to make popup more manageable
        set_wrap_width (5);

        expand = false;
    }

    /** Controls the wattage */
    public int wattage {
        get { return min_wattage + active * step; }
        set { active = (value - min_wattage) / step; }
    }
}