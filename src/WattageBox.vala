public class WattageBox : Gtk.ComboBox {
    protected int min_wattage = 300;
    protected int max_wattage = 1300;
    protected int step = 25;
    protected enum Column {
        WATTAGE
    }

    /** Constructor */
    public WattageBox () {
        // Create list of wattages
        Gtk.ListStore liststore = new Gtk.ListStore(1, typeof (string));
        for (int i = min_wattage; i <= max_wattage; i += step) {
            Gtk.TreeIter iter;
            liststore.append (out iter);
            liststore.set (iter, Column.WATTAGE, i.to_string() + "W");
        }
        set_model(liststore);

        // Render cells
        Gtk.CellRendererText cell = new Gtk.CellRendererText ();
        pack_start (cell, false);
        set_attributes (cell, "text", Column.WATTAGE);

        // Set the first wattage as active
        set_active (0);
    }

    /** Controls the wattage */
    public int wattage {
        get { return min_wattage + active * step; }
        set { active = (value - min_wattage) / step; }
    }
}