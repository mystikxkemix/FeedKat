package polytech.feedkat;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.FloatRange;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

public class NavigationActivity extends Activity {

    private ImageView buttonCat, buttonHome, buttonSettings;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_navigation);

        //Création des variables

        int size_button = Static.screen_y/20;
        final FrameLayout barre_orange = new FrameLayout(this);
        final TextView t = new TextView(this);

        // Récupération des layout

        FrameLayout body = (FrameLayout)findViewById(R.id.body);
        FrameLayout body_scroll = (FrameLayout)findViewById(R.id.body_scroll);
        ScrollView scroll = (ScrollView)findViewById(R.id.scroll);
        FrameLayout header = (FrameLayout)findViewById(R.id.header);
        FrameLayout footer = (FrameLayout)findViewById(R.id.footer);
        buttonCat = (ImageView) findViewById(R.id.buttonCat);
        buttonHome = (ImageView) findViewById(R.id.buttonHome);
        buttonSettings = (ImageView) findViewById(R.id.buttonSettings);

        //footer
        FrameLayout.LayoutParams lp_footer = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y/10);
        lp_footer.gravity = Gravity.BOTTOM;
        footer.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        footer.setLayoutParams(lp_footer);
            //Barre footer
        final FrameLayout.LayoutParams lp_barre = new FrameLayout.LayoutParams(Static.screen_x/3,Static.screen_y/100);
        lp_barre.gravity = Gravity.TOP;
        barre_orange.setBackgroundColor(getResources().getColor(R.color.colorBarre));
        lp_barre.setMargins(0,0,0,0);
        barre_orange.setLayoutParams(lp_barre);
            //Boutons footer
        FrameLayout.LayoutParams lp_button_cat = new FrameLayout.LayoutParams(size_button,size_button);
        lp_button_cat.gravity = Gravity.CENTER;
        buttonCat.setLayoutParams(lp_button_cat);
        FrameLayout.LayoutParams lp_button_home = new FrameLayout.LayoutParams(size_button,size_button);
        lp_button_home.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        lp_button_home.setMargins((Static.screen_x/3-size_button)/2,0,0,0);
        buttonHome.setLayoutParams(lp_button_home);
        FrameLayout.LayoutParams lp_button_settings = new FrameLayout.LayoutParams(size_button,size_button);
        lp_button_settings.gravity = Gravity.RIGHT | Gravity.CENTER_VERTICAL;
        lp_button_settings.setMargins(0,0,(Static.screen_x/3-size_button)/2,0);
        buttonSettings.setLayoutParams(lp_button_settings);


        //Header
        FrameLayout.LayoutParams lp_header = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y/10);
        lp_header.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
        header.setLayoutParams(lp_header);
            //Texte header
        t.setGravity(View.TEXT_ALIGNMENT_CENTER);
        t.setTextSize(20);
        t.setText("Accueil");
        FrameLayout.LayoutParams lp_text = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        lp_text.gravity = Gravity.CENTER;
        t.setLayoutParams(lp_text);

        //Body
        FrameLayout.LayoutParams lp_body_scroll = new FrameLayout.LayoutParams(Static.screen_x,(int)(Static.screen_y*0.8));
        lp_body_scroll.setMargins(0,Static.screen_y/10,0,0);
        body_scroll.setLayoutParams(lp_body_scroll);


        //AddView
        footer.addView(barre_orange);
        header.addView(t);



        buttonHome.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Accueil");
                lp_barre.setMargins(0,0,0,0);
                barre_orange.setLayoutParams(lp_barre);
            }
        });
        buttonCat.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Chat");
                lp_barre.setMargins(Static.screen_x/3,0,0,0);
                barre_orange.setLayoutParams(lp_barre);
            }
        });
        buttonSettings.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Options");
                lp_barre.setMargins(Static.screen_x*2/3,0,0,0);
                barre_orange.setLayoutParams(lp_barre);
            }
        });
    }
}
