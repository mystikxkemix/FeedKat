package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import org.w3c.dom.Text;

/**
 * Created by olivierlafon on 02/11/2016.
 */

public class CatDetailTile extends tuile{

    ImageView chat;
    TextView nom_chat;
    TextView next_feedtime;
    TextView last_feedtime;

    public CatDetailTile(Context context, int index, String name, String last_feed, String next_feed){

        super(context, index);

        chat = new ImageView(context);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.8),(int)(Static.tuile_y*0.8));
        lp_c.setMargins((int)(Static.tuile_x*0.02), 0, 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        chat.setLayoutParams(lp_c);
        chat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
        addView(chat);

        nom_chat = new TextView(context);
        FrameLayout.LayoutParams lp_chatNom = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/2);
        lp_chatNom.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatNom.gravity = Gravity.TOP;
        nom_chat.setLayoutParams(lp_chatNom);
        nom_chat.setGravity(Gravity.CENTER);
        nom_chat.setTextSize(20);
        nom_chat.setTextColor(context.getResources().getColor(R.color.colorBarre));
        nom_chat.setText(name);
        addView(nom_chat);


        last_feedtime = new TextView(context);
        FrameLayout.LayoutParams lp_last = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/4);
        lp_last.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8)/2, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        last_feedtime.setLayoutParams(lp_last);
        last_feedtime.setGravity(Gravity.CENTER);
        last_feedtime.setTextColor(Color.BLACK);
        last_feedtime.setText(last_feed);
        addView(last_feedtime);

        next_feedtime = new TextView(context);
        FrameLayout.LayoutParams lp_next = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8)/4);
        lp_next.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8)/4+(int)(Static.tuile_y*0.8)/2, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        next_feedtime.setLayoutParams(lp_next);
        next_feedtime.setGravity(Gravity.CENTER);
        next_feedtime.setTextColor(Color.BLACK);
        next_feedtime.setText(next_feed);
        addView(next_feedtime);
    }
}
