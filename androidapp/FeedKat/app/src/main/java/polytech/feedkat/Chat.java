package polytech.feedkat;

import android.content.Context;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class Chat extends FrameLayout
{
    public Chat (Context context, FrameLayout chat_scroll)
    {
        super(context);

        int i;

        ArrayList<tuile> list = new ArrayList<>();
        for(i = 0;i<2;i++)
        {
            tuile tu = new tuile(context,i);
            list.add(tu);
            chat_scroll.addView(tu);
        }

        FrameLayout bot = new FrameLayout(context);
        FrameLayout.LayoutParams lpbot = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, Static.screen_y/10 + Static.ecart_tuile*2);
        lpbot.setMargins(0,i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile,0,0);
        bot.setLayoutParams(lpbot);
        chat_scroll.addView(bot);

        //Body
        FrameLayout.LayoutParams lp_chat_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile);
        lp_chat_scroll.setMargins(0, Static.screen_y / 10, 0, 0);
        chat_scroll.setLayoutParams(lp_chat_scroll);
    }
}
