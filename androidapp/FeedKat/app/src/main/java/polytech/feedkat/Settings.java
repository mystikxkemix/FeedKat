package polytech.feedkat;

import android.content.Context;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import java.util.ArrayList;

/**
 * Created by olivierlafon on 06/10/2016.
 */
public class Settings extends FrameLayout
{
    public Settings (Context context, FrameLayout settings_scroll)
    {
        super(context);

        int i;

        System.out.println("Truc:  "+ settings_scroll);
        ArrayList<tuile> list = new ArrayList<>();
        for(i = 0;i<3;i++)
        {
            tuile tu = new tuile(context,i);
            list.add(tu);
            settings_scroll.addView(tu);
        }

        FrameLayout bot = new FrameLayout(context);
        FrameLayout.LayoutParams lpbot = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, Static.screen_y/10 + Static.ecart_tuile*2);
        lpbot.setMargins(0,i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile,0,0);
        bot.setLayoutParams(lpbot);
        settings_scroll.addView(bot);

        //Body
        FrameLayout.LayoutParams lp_settings_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, i*(Static.tuile_y+Static.ecart_tuile)+Static.ecart_tuile);
        lp_settings_scroll.setMargins(0, Static.screen_y / 10, 0, 0);
        settings_scroll.setLayoutParams(lp_settings_scroll);
    }
}
