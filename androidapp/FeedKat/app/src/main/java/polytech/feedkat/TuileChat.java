package polytech.feedkat;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.text.InputFilter;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.ArrayList;

public class TuileChat extends tuile{

    static ArrayList<TuileChat> list = null;
    protected ImageView chat;
    protected ImageView etat_chat;
    protected TextView chat_text, nom_chat;
    ListeChat my_cat;
    public TuileChat(final Context context, int index, ListeChat lc)
    {
        super(context, index,1);
        my_cat = lc;
        chat = new ImageView(context);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((Static.tuile_y),(Static.tuile_y));
        lp_c.setMargins((int)(Static.tuile_x*0.01), 0, 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        chat.setLayoutParams(lp_c);
        if(lc.c_photo.equals("")){
            chat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
        }
        else{
            Picasso.with(getContext()).load(lc.c_photo).into(chat);
        }
        addView(chat);

        etat_chat = new ImageView(context);
        FrameLayout.LayoutParams lp_etat = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.35));
        lp_etat.setMargins((int)(Static.tuile_x*0.02)+Static.tuile_y, 0, 0, (int)(Static.tuile_x*0.02));
        lp_etat.gravity = Gravity.LEFT | Gravity.BOTTOM;
        etat_chat.setLayoutParams(lp_etat);
        etat_chat.setAlpha((float) 0.3);
        if(lc.c_statut==1){
            etat_chat.setBackground(getResources().getDrawable(R.drawable.icon_check));
        }
        else{
            etat_chat.setBackground(getResources().getDrawable(R.drawable.icon_cross));
        }

        addView(etat_chat);


        nom_chat = new TextView(context);
        FrameLayout.LayoutParams lp_chatNom = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.8)/2);
        lp_chatNom.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatNom.gravity = Gravity.TOP;
        nom_chat.setLayoutParams(lp_chatNom);
        nom_chat.setGravity(Gravity.CENTER);
        nom_chat.setTextSize(20);
        nom_chat.setTextColor(context.getResources().getColor(R.color.colorBarre));
        nom_chat.setText(lc.c_name);
        addView(nom_chat);

        chat_text = new TextView(context);
        FrameLayout.LayoutParams lp_chatText = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.8)/2);
        lp_chatText.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatText.gravity = Gravity.BOTTOM;
        chat_text.setLayoutParams(lp_chatText);
        chat_text.setGravity(Gravity.CENTER);
        chat_text.setTextColor(Color.BLACK);
        chat_text.setText(lc.c_message);
        addView(chat_text);

        if(list == null)
            list = new ArrayList<>();
        list.add(this);
    }

    public static ArrayList<TuileChat> getList(){
        if(list == null)
        {
            list = new ArrayList<>();
        }
        return list;
    }
}
