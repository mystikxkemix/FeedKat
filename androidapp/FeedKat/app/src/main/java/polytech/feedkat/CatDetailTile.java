package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import org.w3c.dom.Text;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by olivierlafon on 02/11/2016.
 */

public class CatDetailTile extends tuile{

    static ArrayList<CatDetailTile> list = null;

    ImageView chat;
    TextView nom_chat;
    TextView next_feedtime;
    TextView last_feedtime;
    int nb_feedtimes;
    int next_ft_h, next_ft_m, next_ft_s;
    String old_next_ft_h, old_next_ft_m, old_next_ft_s;
    String heure,minute,seconde;
    String ft_h, ft_m,ft_s;
    int ft_total, time_total, old_total, next_total;
    ListeChat my_cat;


    public CatDetailTile(Context context, int index, ListeChat cat){

        super(context, index, 1);

        my_cat = cat;

        nb_feedtimes = cat.ft.size();
        Date d = new Date();
        SimpleDateFormat get_h = new SimpleDateFormat("HH");
        heure = get_h.format(d);
        SimpleDateFormat get_m = new SimpleDateFormat("mm");
        minute = get_m.format(d);
        SimpleDateFormat get_s = new SimpleDateFormat("ss");
        seconde = get_s.format(d);
        time_total = (Integer.parseInt(heure)*60 + Integer.parseInt(minute))*60 + Integer.parseInt(seconde);
        old_next_ft_h = "23";
        old_next_ft_m = "59";
        old_next_ft_s = "59";
        old_total = 23*60*60 + 59*60 + 59;
        for(int i = 0; i < nb_feedtimes ; i++)
        {
            System.out.println(cat.ft.get(i).f_time);
            ft_h = cat.ft.get(i).f_time.substring(0,2);
            ft_m = cat.ft.get(i).f_time.substring(3,5);
            ft_s = cat.ft.get(i).f_time.substring(6,8);

            ft_total = (Integer.parseInt(ft_h)*60 + Integer.parseInt(ft_h))*60 + Integer.parseInt(ft_s)-720;
            System.out.println(ft_total);
            if ((time_total - ft_total) > 0){
                next_total = ft_total + (24*60*60-time_total);
            }
            else if ((time_total - ft_total) == 0){
                next_total = ft_total;
            }
            else{
                next_total = ft_total - time_total;
            }

            if(old_total > next_total){
                old_total = next_total;
            }
        }

        next_ft_h = old_total / 3600;
        next_ft_m = (old_total - (next_ft_h * 3600)) / 60;
        next_ft_s = (old_total - (next_ft_m * 60) - (next_ft_h * 3600));

        chat = new ImageView(context);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams(Static.tuile_y,Static.tuile_y);
        lp_c.setMargins((int)(Static.tuile_x*0.01), 0, 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        chat.setLayoutParams(lp_c);
        if(cat.c_photo.equals("")){
            chat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
        }
        else{
            Picasso.with(getContext()).load(cat.c_photo).into(chat);
        }
        addView(chat);

        nom_chat = new TextView(context);
        FrameLayout.LayoutParams lp_chatNom = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/2);
        lp_chatNom.setMargins((int)(Static.tuile_x*0.02)*3+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatNom.gravity = Gravity.TOP;
        nom_chat.setLayoutParams(lp_chatNom);
        nom_chat.setGravity(Gravity.CENTER);
        nom_chat.setTextSize(20);
        nom_chat.setTextColor(context.getResources().getColor(R.color.colorBarre));
        nom_chat.setText(cat.c_name);
        addView(nom_chat);


        last_feedtime = new TextView(context);
        FrameLayout.LayoutParams lp_last = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/4);
        lp_last.setMargins((int)(Static.tuile_x*0.02)*3+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8)/2, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        last_feedtime.setLayoutParams(lp_last);
        last_feedtime.setGravity(Gravity.CENTER);
        last_feedtime.setTextColor(Color.BLACK);
        last_feedtime.setText("lol");
        addView(last_feedtime);

        next_feedtime = new TextView(context);
        FrameLayout.LayoutParams lp_next = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/4);
        lp_next.setMargins((int)(Static.tuile_x*0.02)*3+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8)/4+(int)(Static.tuile_y*0.8)/2, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        next_feedtime.setLayoutParams(lp_next);
        next_feedtime.setGravity(Gravity.CENTER);
        next_feedtime.setTextColor(Color.BLACK);
        if(nb_feedtimes==0){
            next_feedtime.setText("Votre chat n'a pas de repas prévu");
        }
        else {
            next_feedtime.setText("Votre chat mangera dans " + next_ft_h + "h" + next_ft_m + "m");
        }
        addView(next_feedtime);
        if(list == null)
            list = new ArrayList<>();
        list.add(this);
    }

    public static ArrayList<CatDetailTile> getList(){
        if(list == null)
        {
            list = new ArrayList<>();
        }
        return list;
    }
}
