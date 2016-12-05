
package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;


/**
 * Created by olivierlafon on 05/10/2016.
 */
public class tuile extends FrameLayout
{
    protected View v;
    private static int endPrev = 0;

    public static void resetEnd()
    {
        endPrev = 0;
    }

    public tuile(Context context, int index, int type)
    {
        super(context);
        this.setBackgroundColor(Color.WHITE);
        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(Static.tuile_x,type*Static.tuile_y);
        lp.setMargins(Static.ecart_bordure,endPrev+Static.ecart_tuile/2,Static.ecart_bordure,Static.ecart_bordure/2);
        this.setLayoutParams(lp);

        endPrev += type*Static.tuile_y + Static.ecart_tuile;

        v = new View(context);

        FrameLayout.LayoutParams lp_v = new FrameLayout.LayoutParams(Static.tuile_x/100, ViewGroup.LayoutParams.MATCH_PARENT);
        v.setBackgroundColor(context.getResources().getColor(R.color.colorBarre));
        v.setLayoutParams(lp_v);
        addView(v);

    }

}




