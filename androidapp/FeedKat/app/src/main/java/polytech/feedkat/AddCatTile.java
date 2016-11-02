package polytech.feedkat;

import android.content.Context;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.ImageView;

/**
 * Created by olivierlafon on 02/11/2016.
 */

public class AddCatTile extends tuile{

    protected ImageView addCat;

    public AddCatTile(Context context, int index){
        super(context, index);
        addCat = new ImageView(context);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.8),(int)(Static.tuile_y*0.8));
        lp_c.setMargins((int)(Static.tuile_x*0.02), 0, 0, 0);
        lp_c.gravity = Gravity.CENTER;
        addCat.setLayoutParams(lp_c);
        addCat.setBackground(getResources().getDrawable(R.drawable.icon_plus));
        addView(addCat);
    }
}
