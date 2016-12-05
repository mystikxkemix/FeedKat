package polytech.feedkat;

import java.util.ArrayList;

/**
 * Created by kevin on 16/11/2016.
 */

public class Dispenser {

    static ArrayList<Dispenser> list = null;
    int d_id;
    String d_name;
    int d_stock;

    public Dispenser(int id_dispenser, String name, int stock){
        d_id = id_dispenser;
        d_name = name;
        d_stock = stock;
        if(list == null)
            list = new ArrayList<>();
        list.add(this);
    }

    public static ArrayList<Dispenser> getList(){
        if(list == null)
        {
            list = new ArrayList<>();
        }
        return list;
    }
}
