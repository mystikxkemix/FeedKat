package polytech.feedkat;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.squareup.picasso.Picasso;

import org.json.JSONObject;

/**
 * Created by kevin on 16/11/2016.
 */

public class FocusedCatTile extends Activity{

    int id_chat;
    ListeChat cat;
    int last_page;
    ImageView photo_cat;
    int mode;
    EditText name;
    TextView nom;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_focused);
        id_chat = getIntent().getIntExtra("id_cat", -1);
        last_page = getIntent().getIntExtra("last_page", 0);
        mode = getIntent().getIntExtra("mode",0);
        System.out.println("mode = " +mode);

        TextView t = new TextView(getApplicationContext());
        FrameLayout focused = (FrameLayout)findViewById(R.id.focused);

        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        focused.setLayoutParams(lp);

        for (int i = 0 ; i < ListeChat.getList().size() ; i++) {
            if (ListeChat.getList().get(i).c_id == id_chat) {
                cat = ListeChat.getList().get(i);
                break;
            }
        }

        FrameLayout header = new FrameLayout(getApplicationContext());
        FrameLayout.LayoutParams lp_header = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, Static.screen_y / 10);
        lp_header.gravity = Gravity.CENTER_HORIZONTAL | Gravity.TOP;
        header.setLayoutParams(lp_header);
        header.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));

        FrameLayout.LayoutParams lp_text = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT);
        lp_text.gravity = Gravity.CENTER;
        t.setLayoutParams(lp_text);

        focused.addView(header);
        t.setText(cat.c_name);
        t.setTextSize(20);
        t.setTextColor(getResources().getColor(R.color.colorPrimary));
        header.addView(t);

        FrameLayout body = new FrameLayout(getApplicationContext());
        FrameLayout.LayoutParams lp_body = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (int)(Static.screen_y*0.9));
        lp_body.setMargins(0,Static.screen_y/10,0,0);
        body.setLayoutParams(lp_body);
        focused.addView(body);

        tuile informations = new tuile (getApplicationContext(),0,3);
        body.addView(informations);

        FrameLayout barre_info = new FrameLayout(getApplicationContext());
        FrameLayout.LayoutParams lp_barre_info = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (int)(Static.tuile_y*0.6));
        barre_info.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        lp_barre_info.gravity=Gravity.TOP;
        barre_info.setLayoutParams(lp_barre_info);
        informations.addView(barre_info);

        TextView text_info = new TextView(getApplicationContext());
        text_info.setText("Informations");
        text_info.setTextColor(getResources().getColor(R.color.colorPrimary));
        text_info.setTextSize(20);
        FrameLayout.LayoutParams lp_text_info = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_text_info.gravity = Gravity.LEFT|Gravity.CENTER_VERTICAL;
        lp_text_info.setMargins(Static.screen_x/100,0,0,0);
        text_info.setLayoutParams(lp_text_info);
        barre_info.addView(text_info);

        TextView edit_info = new TextView(getApplicationContext());
        edit_info.setText("Editer");
        if(mode==0){
            edit_info.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
        else{
            edit_info.setTextColor(getResources().getColor(R.color.colorBarre));
        }
        edit_info.setTextSize(20);
        FrameLayout.LayoutParams lp_edit_info = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_edit_info.gravity = Gravity.RIGHT|Gravity.CENTER_VERTICAL;
        lp_edit_info.setMargins(0,0,Static.screen_x/100,0);
        edit_info.setLayoutParams(lp_edit_info);
        barre_info.addView(edit_info);

        photo_cat = new ImageView(getApplicationContext());
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((int)(Static.tuile_y*1.2),(int)(Static.tuile_y*1.2));
        lp_c.setMargins(Static.tuile_x/100, (int)(Static.tuile_y*0.6), 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.TOP;
        photo_cat.setLayoutParams(lp_c);
        if(cat.c_photo.equals("")){
            photo_cat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
        }
        else{
            Picasso.with(getApplicationContext()).load(cat.c_photo).into(photo_cat);
        }
        informations.addView(photo_cat);

        if(mode==0){
            nom = new TextView(getApplicationContext());
            nom.setText("Nom : " + cat.c_name);
            nom.setTextSize(15);
            nom.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_nom = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_nom.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*0.6),0,0);
            nom.setLayoutParams(lp_nom);
            informations.addView(nom);
            informations.removeView(name);
        }
        else{
            name = new EditText(getApplicationContext());
            name.setTextSize(15);
            name.setText(cat.c_name);
            name.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_name = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_name.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*0.6),0,0);
            name.setLayoutParams(lp_name);
            name.setSelection(name.length());
            informations.addView(name);
            informations.removeView(nom);
        }


        TextView birth = new TextView(getApplicationContext());
        birth.setText("Date de naissance : " + getFrenchDate(cat.c_date_naissance));
        birth.setTextSize(15);
        birth.setTextColor(Color.BLACK);
        FrameLayout.LayoutParams lp_birth = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_birth.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y),0,0);
        birth.setLayoutParams(lp_birth);
        informations.addView(birth);

        TextView weight = new TextView(getApplicationContext());
        weight.setText("Poids : " + (double)(cat.c_poids*0.001) + "kg");
        weight.setTextSize(15);
        weight.setTextColor(Color.BLACK);
        FrameLayout.LayoutParams lp_weight = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_weight.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*1.4),0,0);
        weight.setLayoutParams(lp_weight);
        informations.addView(weight);




        edit_info.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                System.out.println("mort de lol");
                Intent intent = new Intent(FocusedCatTile.this, FocusedCatTile.class);
                intent.putExtra("id_cat", id_chat);
                intent.putExtra("last_page", last_page);
                if(mode==0){
                    intent.putExtra("mode",1);
                }
                else{
                    intent.putExtra("mode",0);
                    FeedKatAPI.getInstance(null).ModifyCat(cat.c_id, name.getText().toString(), cat.c_date_naissance, new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            System.out.println("ok");
                            cat.c_name= name.getText().toString();
                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            System.out.println("nok");
                        }
                    });
                }
                startActivity(intent);
            }
        });
    }

    public void onStart() {
        super.onStart();
    }

    @Override
    public void onStop() {
        super.onStop();
    }

    public void onBackPressed(){
        Intent intent = new Intent(FocusedCatTile.this,NavigationActivity.class);
        intent.putExtra("page", last_page);
        startActivity(intent);
    }

    public String getFrenchDate(String date){
        String FrenchDate,jour,mois,annee;
        annee = date.substring(0,4);
        mois = date.substring(5,7);
        jour = date.substring(8,10);
        FrenchDate = jour + "-" + mois + "-" + annee;
        return FrenchDate;
    }
}

