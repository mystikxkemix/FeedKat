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
public class TuileAlerte extends tuile{

    protected ImageView alert;
    protected TextView alert_text;
    public TuileAlerte(Context context, int index)
    {
        super(context, index);
        this.setBackgroundColor(context.getResources().getColor(R.color.colorAlert));

        alert = new ImageView(context);
        FrameLayout.LayoutParams lp_v = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.8),(int)(Static.tuile_y*0.8));
        lp_v.setMargins((int)(Static.tuile_x*0.02), 0, 0, 0);
        lp_v.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        alert.setLayoutParams(lp_v);
        alert.setBackground(getResources().getDrawable(R.drawable.icon_alert));
        addView(alert);
        removeView(this.v);

        alert_text = new TextView(context);
        FrameLayout.LayoutParams lp_textAlert = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3, (int)(Static.tuile_y*0.8));
        lp_textAlert.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_textAlert.gravity = Gravity.CENTER_VERTICAL;
        alert_text.setLayoutParams(lp_textAlert);
        alert_text.setGravity(Gravity.CENTER);
        alert_text.setTextColor(Color.WHITE);
        alert_text.setTextSize(20);
        alert_text.setText("Il reste 10% de croquettes");
        addView(alert_text);

    }
}
