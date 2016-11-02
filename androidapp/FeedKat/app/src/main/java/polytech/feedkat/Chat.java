package polytech.feedkat;

import android.content.Context;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class Chat extends FrameLayout
{
    FrameLayout.LayoutParams lpbot;
    FrameLayout.LayoutParams lp_chat_scroll;
    int nb_feedtimes;
    String last_feed;

    public Chat (Context context, FrameLayout chat_scroll)
    {
        super(context);
        int k;
        for(k = 0 ; k < ListeChat.getList().size(); k++){
            ListeChat lc = ListeChat.getList().get(k);
            nb_feedtimes = lc.ft.size();
            GregorianCalendar calendar = new GregorianCalendar();
            Date time  = calendar.getTime();
            System.out.println("time" + time);
        }


        k++;
        lpbot = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, Static.screen_y/10 + Static.ecart_tuile*2);
        lpbot.setMargins(0,k*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile,0,0);
        lp_chat_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, k*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile);
        lp_chat_scroll.setMargins(0, Static.screen_y / 10, 0, 0);

        FrameLayout bot = new FrameLayout(context);
        bot.setLayoutParams(lpbot);
        chat_scroll.addView(bot);

        //Body

        chat_scroll.setLayoutParams(lp_chat_scroll);
    }
}
