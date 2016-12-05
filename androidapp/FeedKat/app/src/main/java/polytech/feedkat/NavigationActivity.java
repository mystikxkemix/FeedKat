package polytech.feedkat;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

import static polytech.feedkat.UserData.id_user;

public class NavigationActivity extends Activity {

    private ImageView buttonCat, buttonHome, buttonSettings;
    private FrameLayout body_scroll;
    private Accueil accueil;
    private Chat chat;
    private Settings settings;
    private FocusedCatTile focusedTile;
    private FrameLayout settings_scroll;
    private FrameLayout chat_scroll;
    private FrameLayout focused_scroll;
    private ScrollView scroll;
    private TextView t;
    private FrameLayout.LayoutParams lp_barre;
    private FrameLayout barre_orange;
    private View chat_view, accueil_view, settings_view;
    private int id_user ;
    private ListeChat cat;
    int a;
    int page;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        id_user = getIntent().getIntExtra("id_user", -1);
        setContentView(R.layout.activity_navigation);

        //Création des variables

        int size_button = Static.screen_y / 20;
        barre_orange = new FrameLayout(this);

        t = new TextView(this);

        // Récupération des layout
        settings_scroll = new FrameLayout(this);
        chat_scroll = new FrameLayout(this);
        body_scroll = (FrameLayout) findViewById(R.id.body_scroll);
        focused_scroll = new FrameLayout(this);
        scroll = (ScrollView) findViewById(R.id.scroll);

        FrameLayout header = (FrameLayout) findViewById(R.id.header);
        FrameLayout footer = (FrameLayout) findViewById(R.id.footer);
        buttonCat = (ImageView) findViewById(R.id.buttonCat);
        buttonHome = (ImageView) findViewById(R.id.buttonHome);
        buttonSettings = (ImageView) findViewById(R.id.buttonSettings);


        //footer
        FrameLayout.LayoutParams lp_footer = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y / 10);
        lp_footer.gravity = Gravity.BOTTOM;
        footer.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        footer.setLayoutParams(lp_footer);
        //Barre footer
        lp_barre = new FrameLayout.LayoutParams(Static.screen_x / 3, Static.screen_y / 100);
        lp_barre.gravity = Gravity.TOP;
        barre_orange.setBackgroundColor(getResources().getColor(R.color.colorBarre));
        lp_barre.setMargins(0, 0, 0, 0);
        barre_orange.setLayoutParams(lp_barre);
        //Boutons footer


        accueil_view = new View(this);
        FrameLayout.LayoutParams lp_view_accueil = new FrameLayout.LayoutParams(Static.screen_x/3,Static.screen_y/10);
        lp_view_accueil.gravity = Gravity.LEFT;
        accueil_view.setLayoutParams(lp_view_accueil);

        settings_view = new View(this);
        FrameLayout.LayoutParams lp_view_settings = new FrameLayout.LayoutParams(Static.screen_x/3,Static.screen_y/10);
        lp_view_settings.gravity = Gravity.RIGHT;
        settings_view.setLayoutParams(lp_view_settings);

        chat_view = new View(this);
        FrameLayout.LayoutParams lp_view_chat = new FrameLayout.LayoutParams(Static.screen_x/3,Static.screen_y/10);
        lp_view_chat.gravity = Gravity.CENTER;
        chat_view.setLayoutParams(lp_view_chat);


        FrameLayout.LayoutParams lp_button_cat = new FrameLayout.LayoutParams(size_button, size_button);
        lp_button_cat.gravity = Gravity.CENTER;
        buttonCat.setLayoutParams(lp_button_cat);
        FrameLayout.LayoutParams lp_button_home = new FrameLayout.LayoutParams(size_button, size_button);
        lp_button_home.gravity = Gravity.LEFT | Gravity.CENTER_VERTICAL;
        lp_button_home.setMargins((Static.screen_x / 3 - size_button) / 2, 0, 0, 0);
        buttonHome.setLayoutParams(lp_button_home);
        FrameLayout.LayoutParams lp_button_settings = new FrameLayout.LayoutParams(size_button, size_button);
        lp_button_settings.gravity = Gravity.RIGHT | Gravity.CENTER_VERTICAL;
        lp_button_settings.setMargins(0, 0, (Static.screen_x / 3 - size_button) / 2, 0);
        buttonSettings.setLayoutParams(lp_button_settings);

        footer.addView(chat_view);
        footer.addView(settings_view);
        footer.addView(accueil_view);

        //Header
        FrameLayout.LayoutParams lp_header = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y / 10);
        lp_header.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
        header.setLayoutParams(lp_header);





        //Texte header
        t.setGravity(View.TEXT_ALIGNMENT_CENTER);
        t.setTextSize(20);
        t.setText("Accueil");
        accueil = new Accueil(this, body_scroll);
        chat = new Chat(this,chat_scroll);
        settings = new Settings(this, settings_scroll);

        FrameLayout.LayoutParams lp_text = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        lp_text.gravity = Gravity.CENTER;
        t.setLayoutParams(lp_text);


        //AddView
        footer.addView(barre_orange);
        header.addView(t);

        page = getIntent().getIntExtra("page",0);

        if(page == 0){
            t.setText("Accueil");
            lp_barre.setMargins(0, 0, 0, 0);
            barre_orange.setLayoutParams(lp_barre);
            scroll.removeAllViews();
            Runtime.getRuntime().gc();
            accueil = new Accueil(getApplicationContext(), body_scroll);
            scroll.addView(body_scroll);
        }
        else{
            t.setText("Chat");
            lp_barre.setMargins(Static.screen_x / 3, 0, 0, 0);
            barre_orange.setLayoutParams(lp_barre);
            scroll.removeAllViews();
            chat = new Chat(getApplicationContext(),chat_scroll);
            scroll.addView(chat_scroll);
            Runtime.getRuntime().gc();
        }

        accueil_view.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Accueil");
                lp_barre.setMargins(0, 0, 0, 0);
                barre_orange.setLayoutParams(lp_barre);
                scroll.removeAllViews();
                Runtime.getRuntime().gc();
                accueil = new Accueil(getApplicationContext(), body_scroll);
                scroll.addView(body_scroll);
            }
        });
        chat_view.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Chat");
                lp_barre.setMargins(Static.screen_x / 3, 0, 0, 0);
                barre_orange.setLayoutParams(lp_barre);
                scroll.removeAllViews();
                chat = new Chat(getApplicationContext(),chat_scroll);
                scroll.addView(chat_scroll);
                Runtime.getRuntime().gc();
            }
        });
        settings_view.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                t.setText("Options");
                lp_barre.setMargins(Static.screen_x * 2 / 3, 0, 0, 0);
                barre_orange.setLayoutParams(lp_barre);
                scroll.removeAllViews();
                settings = new Settings(getApplicationContext(),settings_scroll);
                scroll.addView(settings_scroll);
                Runtime.getRuntime().gc();
            }
        });

        for( a = 0 ; a < TuileChat.getList().size(); a ++){
            final ListeChat lc = TuileChat.getList().get(a).my_cat;
            TuileChat.getList().get(a).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(NavigationActivity.this, FocusedCatTile.class);
                    intent.putExtra("id_cat", lc.c_id);
                    intent.putExtra("last_page", 0);
                    startActivity(intent);
                }
            });
        }

        for( a = 0 ; a < CatDetailTile.getList().size(); a ++){
            final ListeChat lc = CatDetailTile.getList().get(a).my_cat;
            CatDetailTile.getList().get(a).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(NavigationActivity.this, FocusedCatTile.class);
                    intent.putExtra("id_cat", lc.c_id);
                    intent.putExtra("last_page", 1);
                    startActivity(intent);
                }
            });
        }

    }

    @Override
    public void onStart() {
        super.onStart();
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    public void onBackPressed(){
        t.setText("Accueil");
        lp_barre.setMargins(0, 0, 0, 0);
        barre_orange.setLayoutParams(lp_barre);
        scroll.removeAllViews();
        Runtime.getRuntime().gc();
        accueil = new Accueil(getApplicationContext(), body_scroll);
        scroll.addView(body_scroll);
        return;
    }
}
