package polytech.feedkat;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 02/11/2016.
 */

public class Feedtimes {

    int f_id;
    int f_dispenser;
    String f_time;
    int f_weight;
    int f_enabled;

    public Feedtimes(int id, int id_dispenser, String time, int weight, int enabled){
        f_id = id;
        f_dispenser = id_dispenser;
        f_time = time;
        f_weight = weight;
        f_enabled = enabled;
    }
}
