package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by olivierlafon on 07/10/2016.
 */
public class TuileDistributeur extends tuile {

    protected ImageView distributeur;
    protected TextView nom_distrib;
    protected View distrib_text;
    protected View limite_jauge;
    protected TextView croquette;

    public TuileDistributeur(Context context, int index, double remplissage)
    {
        super(context,index);

        distributeur = new ImageView(context);
        FrameLayout.LayoutParams lp_v = new FrameLayout.LayoutParams((int)(Static.tuile_y*0.8),(int)(Static.tuile_y*0.8));
        lp_v.setMargins((int)(Static.tuile_x*0.02), 0, 0, 0);
        lp_v.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        distributeur.setLayoutParams(lp_v);
        distributeur.setBackground(getResources().getDrawable(R.drawable.icon_dis));
        addView(distributeur);



        nom_distrib = new TextView(context);
        FrameLayout.LayoutParams lp_chatNom = new FrameLayout.LayoutParams(Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35), (int)(Static.tuile_y*0.8)/2);
        lp_chatNom.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_chatNom.gravity = Gravity.TOP;
        nom_distrib.setLayoutParams(lp_chatNom);
        nom_distrib.setGravity(Gravity.CENTER);
        nom_distrib.setTextSize(20);
        nom_distrib.setTextColor(context.getResources().getColor(R.color.colorBarre));
        nom_distrib.setText("Respo Alimentation");
        addView(nom_distrib);

        distrib_text = new View(context);
        FrameLayout.LayoutParams lp_distrib = new FrameLayout.LayoutParams((int)((Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35))*remplissage), (int)(Static.tuile_y*0.8)/4);
        lp_distrib.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        lp_distrib.gravity = Gravity.BOTTOM;
        distrib_text.setLayoutParams(lp_distrib);

        if(remplissage < 0.25)
        {
            distrib_text.setBackgroundColor(context.getResources().getColor(R.color.colorAlert));
        }
        else if (remplissage < 0.5)
        {
            distrib_text.setBackgroundColor(context.getResources().getColor(R.color.colorBarre));
        }
        else if (remplissage < 0.75)
        {
            distrib_text.setBackgroundColor(Color.YELLOW);
        }
        else
        {
            distrib_text.setBackgroundColor(Color.GREEN);
        }
        addView(distrib_text);

        croquette = new TextView(context);
        FrameLayout.LayoutParams lp_croquette = new FrameLayout.LayoutParams((int)((Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35))), (int)(Static.tuile_y*0.8)/4);
        lp_croquette.gravity = Gravity.TOP;
        lp_croquette.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35), (int)(Static.tuile_x*0.02)+(int)(Static.tuile_y*0.8)/2, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        croquette.setLayoutParams(lp_croquette);
        croquette.setTextColor(Color.BLACK);
        croquette.setText("Niveau de croquettes :");
        addView(croquette);



        GradientDrawable border = new GradientDrawable();
        border.setStroke(2, 0xFF000000);
        limite_jauge = new View(context);
        FrameLayout.LayoutParams lp_limite = new FrameLayout.LayoutParams((Static.tuile_x - (int)(Static.tuile_y*0.8)-(int)(Static.tuile_x*0.02)*3 - (int)(Static.tuile_y*0.35))+10, (int)(Static.tuile_y*0.8)/4+10);
        lp_limite.setMargins((int)(Static.tuile_x*0.02)*2+(int)(Static.tuile_y*0.8) + (int)(Static.tuile_y*0.35)-5, (int)(Static.tuile_x*0.02) +(int)(Static.tuile_y*0.8)/2+(int)(Static.tuile_y*0.8)/3-5, (int)(Static.tuile_x*0.02), (int)(Static.tuile_x*0.02));
        //lp_limite.gravity = Gravity.BOTTOM;
        limite_jauge.setLayoutParams(lp_limite);
        limite_jauge.setBackgroundColor(0x00000000);
        limite_jauge.setBackground(border);
        addView(limite_jauge);

    }
}
