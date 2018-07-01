/**
 * DurationSelector
 * ---
 * Allows the user to select the duration of a cook.
 */
public class DurationSelector : Gtk.Grid {
    private Gtk.Label divider;
    private Gtk.SpinButton minutes;
    private Gtk.SpinButton seconds;
    public signal void changed ();

    /** Constructor */
    public DurationSelector () {
        // Minutes counter
        minutes = new Gtk.SpinButton.with_range (0, 99, 1);
        minutes.orientation = Gtk.Orientation.VERTICAL;
        minutes.value_changed.connect (on_change);
        add (minutes);

        // : Divider
        divider = new Gtk.Label (":");
        add (divider);

        // Seconds counter
        seconds = new Gtk.SpinButton.with_range (0, 59, 1);
        seconds.orientation = Gtk.Orientation.VERTICAL;
        seconds.output.connect (on_output);
        seconds.value_changed.connect (on_change);
        seconds.wrapped.connect (when_seconds_wrapped);
        add (seconds);

        // Perform a change
    }

    private void on_change () {
        seconds.wrap = (minutes.value > 0 || seconds.value > 0);
        changed ();
    }

    private bool on_output (Gtk.SpinButton spin_button) {
        var text = spin_button.value.to_string ();
        if (spin_button.value < 10) {
            text = "0" + text;
        }
        spin_button.set_text (text);
        return true;
    }

    private void when_seconds_wrapped () {
        if (seconds.value == 59) {
            if (minutes.value == 0) {
                seconds.value = 0;
            } else {
                minutes.value --;
            }
        } else {
            minutes.value ++;
        }
    }

    public int time {
        get {
            return (int)(seconds.value + minutes.value * 60); }
        set {
            seconds.value = value % 60;
            minutes.value = Math.floor (value / 60);
        }
    }
}