package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.text.InputFilter;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class TuileChatNOK extends tuile{

    protected ImageView chat;
    protected ImageView etat_chat;
    protected TextView chat_text, nom_chat;
    public TuileChatNOK(Context context, int index)
    {
        super(context, index);

        chat = new ImageView(context);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.8),(int)(Static.tuile_y*0.8));
        lp_c.setMargins((int)(Static.tuile_x*0.02), 0, 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        chat.setLayoutParams(lp_c);
        chat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
        addView(chat);

        etat_chat = new ImageView(context);
        FrameLayout.LayoutParams lp_etat = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.35));
        lp_etat.setMargins((int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8), 0, 0, (int)(Static.tuile_x*0.02));
        lp_etat.gravity = Gravity.LEFT | Gravity.BOTTOM;
        etat_chat.setLayoutParams(lp_etat);
        etat_chat.setAlpha((float) 0.3);
        etat_chat.setBackground(getResources().getDrawable(R.drawable.icon_cross));
        addView(etat_chat);


        nom_chat = new TextView(context);
        FrameLayout.LayoutParams lp_chatNom = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.8)/2);
        lp_chatNom.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatNom.gravity = Gravity.TOP;
        nom_chat.setLayoutParams(lp_chatNom);
        nom_chat.setGravity(Gravity.CENTER);
        nom_chat.setTextSize(20);
        nom_chat.setTextColor(context.getResources().getColor(R.color.colorBarre));
        nom_chat.setText("Batman");
        addView(nom_chat);

        chat_text = new TextView(context);
        FrameLayout.LayoutParams lp_chatText = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.8)/2);
        lp_chatText.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatText.gravity = Gravity.BOTTOM;
        chat_text.setLayoutParams(lp_chatText);
        chat_text.setGravity(Gravity.CENTER);
        chat_text.setText("Votre chat n'a pas mangé depuis 42jours");
        chat_text.setTextColor(Color.BLACK);
        addView(chat_text);


    }
}
