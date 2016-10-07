package polytech.feedkat;

import android.content.Context;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.ScrollView;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class Accueil extends FrameLayout
{
    public Accueil(Context context, FrameLayout body_scroll)
    {
        super(context);

        int i = 4;

        ArrayList<tuile> list = new ArrayList<>();

        TuileAlerte tua = new TuileAlerte(context,0);
        list.add(tua);
        body_scroll.addView(tua);

        TuileChatNOK tucn = new TuileChatNOK(context,1);
        list.add(tucn);
        body_scroll.addView(tucn);

        TuileChat tuc = new TuileChat(context,2);
        list.add(tuc);
        body_scroll.addView(tuc);

        TuileDistributeur tud = new TuileDistributeur(context,3,0.1);
        list.add(tud);
        body_scroll.addView(tud);

        FrameLayout bot = new FrameLayout(context);
        FrameLayout.LayoutParams lpbot = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, Static.screen_y/10 + Static.ecart_tuile*2);
        lpbot.setMargins(0,i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile,0,0);
        bot.setLayoutParams(lpbot);
        body_scroll.addView(bot);

        //Body
        FrameLayout.LayoutParams lp_body_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile);
        lp_body_scroll.setMargins(0, Static.screen_y / 10, 0, 0);
        body_scroll.setLayoutParams(lp_body_scroll);
    }


}

