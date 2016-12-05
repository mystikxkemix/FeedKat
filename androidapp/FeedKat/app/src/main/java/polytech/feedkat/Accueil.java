package polytech.feedkat;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ScrollView;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class Accueil extends FrameLayout
{
    FrameLayout.LayoutParams lpbot;
    FrameLayout.LayoutParams lp_body_scroll;

    public Accueil(final Context context, final FrameLayout body_scroll)
    {
        super(context);
        int k, l;
        for(k = 0 ; k < ListeChat.getList().size(); k++){
            final ListeChat lc = ListeChat.getList().get(k);
            TuileChat tu = new TuileChat(context, k, lc);
            body_scroll.addView(tu);
        }
        k++;
        for(l = 0 ; l < Dispenser.getList().size() ; l++){
            Dispenser disp = Dispenser.getList().get(l);
            TuileDistributeur tu_d = new TuileDistributeur(context, (k-1+l), disp.d_name, disp.d_stock);
            body_scroll.addView(tu_d);
        }
        l++;



        lpbot = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, Static.screen_y/10 + Static.ecart_tuile*2);
        lpbot.setMargins(0,(k+l-2)*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile,0,0);
        lp_body_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (k+l-2)*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile);
        lp_body_scroll.setMargins(0, Static.screen_y / 10, 0, 0);

        FrameLayout bot = new FrameLayout(context);
        bot.setLayoutParams(lpbot);
        body_scroll.addView(bot);

        //Body

        body_scroll.setLayoutParams(lp_body_scroll);
    }


}

