package polytech.feedkat;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 21/10/2016.
 */

public class ListeChat {

    static ArrayList<ListeChat> list = null;
    int c_id;
    String c_name;
    int c_statut;
    String c_message;
    String c_photo;
    String c_date_naissance;
    int c_dispenser;
    ArrayList<Feedtimes> ft = null;

    public ListeChat(int id, String name, int statut, String message, String photo, String birth, int id_dispenser, JSONArray feedtimes){
        c_id = id;
        c_name = name;
        c_message = message;
        c_statut = statut;
        c_date_naissance = birth;
        c_dispenser = id_dispenser;

        ft = new ArrayList<>();
        for (int i = 0; i < feedtimes.length(); i++)
        {
            try {
                JSONObject feed = feedtimes.getJSONObject(i);
                ft.add(new Feedtimes(feed.getInt("id_feedtime"), feed.getInt("id_dispenser"), feed.getString("time"), feed.getInt("weight"), feed.getInt("enabled")));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        c_photo = photo;

        if(list == null)
            list = new ArrayList<>();
        list.add(this);
    }

    public static ArrayList<ListeChat> getList(){
        if(list == null)
        {
            list = new ArrayList<>();
        }
        return list;
    }
}
