package polytech.feedkat;

import android.Manifest;
import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.app.TimePickerDialog;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;
import android.text.format.DateFormat;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.TimePicker;

import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.github.mikephil.charting.charts.LineChart;
import com.squareup.picasso.Picasso;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Calendar;

/**
 * Created by kevin on 16/11/2016.
 */

public class FocusedCatTile extends Activity{

    int id_chat, f, index_ft;
    ListeChat cat;
    int last_page;
    ImageView photo_cat;
    int mode;
    EditText name;
    TextView nom;
    TextView t;
    private ScrollView scroll;
    private int taille_tuile;
    TextView time, editFT;
    TextView addFT;
    private int isEditable;
    static TextView etime;
    static TextView ebirth;

    private static int RESULT_LOAD_IMAGE = 1;
    private static final int MY_PERMISSIONS_REQUEST_READ_STORAGE = 2;
    private String picture = null;

    protected void onCreate(Bundle savedInstanceState) {
        tuile.resetEnd();
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_focused);
        scroll = (ScrollView) findViewById(R.id.scroll_focused);
        FrameLayout.LayoutParams lp_scroll = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        lp_scroll.setMargins(0,Static.screen_y / 10,0,0);
        scroll.setLayoutParams(lp_scroll);
        id_chat = getIntent().getIntExtra("id_cat", -1);
        Log.v("FocusedCatTile", "id_cat" + id_chat);
        last_page = getIntent().getIntExtra("last_page", 0);
        mode = getIntent().getIntExtra("mode",0);
        isEditable = getIntent().getIntExtra("isEditable",0);
        index_ft = getIntent().getIntExtra("index_ft",0);

        t = new TextView(getApplicationContext());
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
        FrameLayout.LayoutParams lp_body = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        body.setLayoutParams(lp_body);
        scroll.addView(body);

        //INFORMATION CHAT
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

        photo_cat = new ImageView(this);
        FrameLayout.LayoutParams lp_c = new FrameLayout.LayoutParams((int)(Static.tuile_y*1.2),(int)(Static.tuile_y*1.2));
        lp_c.setMargins(Static.tuile_x/100, (int)(Static.tuile_y*0.6), 0, 0);
        lp_c.gravity = Gravity.LEFT | Gravity.TOP;
        photo_cat.setLayoutParams(lp_c);
        if(cat.tmp_photo == null){
            if(cat.c_photo.equals("")){
                photo_cat.setBackground(getResources().getDrawable(R.drawable.logo_feedkat_300px));
            }
            else{
                Picasso.with(getApplicationContext()).load(cat.c_photo).into(photo_cat, new com.squareup.picasso.Callback() {
                    @Override
                    public void onSuccess() {
                        cat.tmp_photo = Static.convertProfileImage(((BitmapDrawable)photo_cat.getDrawable()).getBitmap());
                    }

                    @Override
                    public void onError() {

                    }
                });
            }
        }
        else
        {
            photo_cat.setImageBitmap(Static.getProfileImage(getApplicationContext(), cat.tmp_photo));
        }

        informations.addView(photo_cat);

        if(mode==0){
            photo_cat.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    return;
                }
            });

            nom = new TextView(getApplicationContext());
            nom.setText("Nom : " + cat.c_name);
            nom.setTextSize(15);
            nom.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_nom = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_nom.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*0.6),0,0);
            nom.setLayoutParams(lp_nom);
            informations.addView(nom);
            informations.removeView(name);

            TextView birth = new TextView(getApplicationContext());
            birth.setText("Date de naissance : " + getFrenchDate(cat.c_date_naissance));
            birth.setTextSize(15);
            birth.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_birth = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_birth.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y),0,0);
            birth.setLayoutParams(lp_birth);
            informations.addView(birth);
        }
        else{

            photo_cat.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    if (ContextCompat.checkSelfPermission(v.getContext(), Manifest.permission.READ_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED)
                    {

                        Intent i = new Intent(Intent.ACTION_PICK, android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                        startActivityForResult(i, RESULT_LOAD_IMAGE);
                    }
                    else
                    {
                        ActivityCompat.requestPermissions((Activity)v.getContext(),
                                new String[]{Manifest.permission.READ_EXTERNAL_STORAGE},
                                MY_PERMISSIONS_REQUEST_READ_STORAGE);
                    }
                }
            });

            nom = new TextView(getApplicationContext());
            nom.setText("Nom : ");
            nom.setTextSize(15);
            nom.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_nom = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_nom.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*0.6),0,0);
            nom.setLayoutParams(lp_nom);
            informations.addView(nom);

            name = new EditText(getApplicationContext());
            name.setTextSize(15);
            name.setText(cat.c_name);
            name.setTextColor(Color.BLACK);
            FrameLayout.LayoutParams lp_name = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_name.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2)+ Static.tuile_x/8,(int)(Static.tuile_y*0.6),0,0);
            name.setLayoutParams(lp_name);
            name.setSelection(name.length());
            informations.addView(name);

            TextView date_naissance = new TextView(getApplicationContext());
            date_naissance.setText("Date de naissance : ");
            date_naissance.setTextColor(Color.BLACK);
            date_naissance.setTextSize(15);
            FrameLayout.LayoutParams lp_date = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_date.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y),0,0);
            date_naissance.setLayoutParams(lp_date);
            informations.addView(date_naissance);

            ebirth = new TextView(getApplicationContext());
            ebirth.setText(getFrenchDate(cat.c_date_naissance));
            ebirth.setTextSize(15);
            ebirth.setTextColor(getResources().getColor(R.color.colorBarre));
            FrameLayout.LayoutParams lp_ebirth = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
            lp_ebirth.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2) + Static.tuile_x/5 + 20,(int)(Static.tuile_y),Static.ecart_bordure,0);
            lp_ebirth.gravity = Gravity.RIGHT;
            ebirth.setLayoutParams(lp_ebirth);
            informations.addView(ebirth);
            ebirth.setOnClickListener(new View.OnClickListener() {
                public void onClick(View v) {
                    DialogFragment newFragment = new DatePickerFragment();
                    newFragment.show(getFragmentManager(), "datePicker");
                }
            });
        }

        TextView weight = new TextView(getApplicationContext());
        weight.setText("Poids : " + (double)(cat.c_poids*0.001) + "kg");
        weight.setTextSize(15);
        weight.setTextColor(Color.BLACK);
        FrameLayout.LayoutParams lp_weight = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_weight.setMargins(Static.tuile_x/100*2 + (int)(Static.tuile_y*1.2),(int)(Static.tuile_y*1.4),0,0);
        weight.setLayoutParams(lp_weight);
        informations.addView(weight);



        //FEEDTIMES CHAT

        if(cat.ft.size()!=0)
            taille_tuile = cat.ft.size()+1;
        else
            taille_tuile = 1;
        tuile feedtimes = new tuile (getApplicationContext(),1,(int)(taille_tuile/1.3));
        body.addView(feedtimes);

        FrameLayout barre_ft = new FrameLayout(getApplicationContext());
        FrameLayout.LayoutParams lp_barre_ft = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (int)(Static.tuile_y*0.6));
        barre_ft.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        lp_barre_ft.gravity=Gravity.TOP;
        barre_ft.setLayoutParams(lp_barre_ft);
        feedtimes.addView(barre_ft);

        TextView text_ft = new TextView(getApplicationContext());
        text_ft.setText("Feedtimes");
        text_ft.setTextColor(getResources().getColor(R.color.colorPrimary));
        text_ft.setTextSize(20);
        FrameLayout.LayoutParams lp_text_ft = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_text_ft.gravity = Gravity.LEFT|Gravity.CENTER_VERTICAL;
        lp_text_ft.setMargins(Static.screen_x/100,0,0,0);
        text_ft.setLayoutParams(lp_text_ft);
        barre_ft.addView(text_ft);

        for(f =0 ; f < cat.ft.size(); f++) {

            if ((isEditable == 1) && (index_ft == f)) {

                final EditText poids = new EditText(getApplicationContext());
                poids.setText(""+cat.ft.get(f).f_weight);
                poids.setTextColor(Color.BLACK);
                FrameLayout.LayoutParams lp_poids = new FrameLayout.LayoutParams(Static.tuile_x/5, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_poids.setMargins(Static.tuile_x / 100 * 2, (f + 1) * (int) (Static.tuile_y * 0.6), 0, 0);
                poids.setLayoutParams(lp_poids);
                feedtimes.addView(poids);

                TextView gramme = new TextView(getApplicationContext());
                gramme.setText("g à ");
                gramme.setTextColor(Color.BLACK);
                FrameLayout.LayoutParams lp_gramme = new FrameLayout.LayoutParams(Static.tuile_x/5, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_gramme.setMargins(Static.tuile_x / 100 * 2 + Static.tuile_x/5, (f + 1) * (int) (Static.tuile_y * 0.6), 0, 0);
                gramme.setLayoutParams(lp_gramme);
                feedtimes.addView(gramme);

                etime = new TextView(getApplicationContext());
                etime.setText(""+cat.ft.get(f).f_time);
                etime.setTextSize(15);
                etime.setTextColor(Color.BLACK);
                FrameLayout.LayoutParams lp_time = new FrameLayout.LayoutParams(Static.tuile_x/5, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_time.setMargins(Static.tuile_x / 100 * 2 + (int)(Static.tuile_x/3.5), (f + 1) * (int) (Static.tuile_y * 0.6), 0, 0);
                etime.setLayoutParams(lp_time);
                feedtimes.addView(etime);
                etime.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        DialogFragment newFragment = new TimePickerFragment();
                        newFragment.show(getFragmentManager(), "timePicker");
                    }
                });

                editFT = new TextView(getApplicationContext());
                editFT.setText("Editer");
                editFT.setTextSize(15);
                editFT.setTextColor(getResources().getColor(R.color.colorBarre));
                FrameLayout.LayoutParams lp_edit = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_edit.gravity = Gravity.RIGHT;
                lp_edit.setMargins(Static.tuile_x / 100 * 2, (f + 1) * (int) (Static.tuile_y * 0.6), Static.tuile_x / 100 * 2, 0);
                editFT.setLayoutParams(lp_edit);
                feedtimes.addView(editFT);
                editFT.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        final Intent intent = new Intent(FocusedCatTile.this, FocusedCatTile.class);
                        intent.putExtra("isEditable",0);
                        intent.putExtra("id_cat", id_chat);
                        intent.putExtra("last_page", last_page);
                        FeedKatAPI.getInstance(null).ModifyFeedTime(cat.ft.get(index_ft).f_id, Integer.parseInt(poids.getText().toString()), etime.getText().toString(), new Response.Listener<JSONObject>() {
                            @Override
                            public void onResponse(JSONObject response) {
                                cat.ft.get(index_ft).f_weight = Integer.parseInt(poids.getText().toString());
                                cat.ft.get(index_ft).f_time = etime.getText().toString();
                                startActivity(intent);
                            }
                        }, new Response.ErrorListener() {
                            @Override
                            public void onErrorResponse(VolleyError error) {
                            }
                        });
                    }
                });
            }
            else {
                time = new TextView(getApplicationContext());
                time.setText("- " + cat.ft.get(f).f_weight + "g à " + cat.ft.get(f).f_time);
                time.setTextSize(15);
                time.setTextColor(Color.BLACK);
                FrameLayout.LayoutParams lp_time = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_time.setMargins(Static.tuile_x / 100 * 2, (f + 1) * (int) (Static.tuile_y * 0.6), 0, 0);
                time.setLayoutParams(lp_time);
                feedtimes.addView(time);

                editFT = new TextView(getApplicationContext());
                editFT.setText("Editer");
                editFT.setTextSize(15);
                editFT.setId(f);
                editFT.setTextColor(Color.BLACK);
                FrameLayout.LayoutParams lp_edit = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                lp_edit.gravity = Gravity.RIGHT;
                lp_edit.setMargins(Static.tuile_x / 100 * 2, (f + 1) * (int) (Static.tuile_y * 0.6), Static.tuile_x / 100 * 2, 0);
                editFT.setLayoutParams(lp_edit);
                feedtimes.addView(editFT);
                editFT.setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        final Intent intent = new Intent(FocusedCatTile.this, FocusedCatTile.class);
                        intent.putExtra("id_cat", id_chat);
                        intent.putExtra("last_page", last_page);
                        intent.putExtra("index_ft", v.getId());
                        intent.putExtra("isEditable", 1);
                        startActivity(intent);
                    }
                });
            }
        }

        addFT = new TextView(getApplicationContext());
        addFT.setText("Ajouter un Feedtime");
        addFT.setTextSize(15);
        addFT.setTextColor(Color.BLACK);
        FrameLayout.LayoutParams lp_add = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_add.gravity = Gravity.CENTER | Gravity.BOTTOM;
        lp_add.setMargins(0,0,0,Static.ecart_bordure);
        addFT.setLayoutParams(lp_add);
        feedtimes.addView(addFT);
        addFT.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                final Intent intent = new Intent(FocusedCatTile.this, FocusedCatTile.class);
                intent.putExtra("isEditable",0);
                intent.putExtra("id_cat", id_chat);
                intent.putExtra("last_page", last_page);
                FeedKatAPI.getInstance(null).AddFeedtime(cat.c_id, new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        try {
                            Feedtimes newfeed = new Feedtimes(response.getInt("id_feedtime"),1,"00:00:00",0,1);
                            cat.ft.add(newfeed);
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                        startActivity(intent);
                    }
                }, new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {

                    }
                });
            }
        });

        //GRAPHIQUES CHAT

        tuile graphiques = new tuile (getApplicationContext(),2,3);
        body.addView(graphiques);

        FrameLayout barre_graph = new FrameLayout(getApplicationContext());
        FrameLayout.LayoutParams lp_barre_graph = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, (int)(Static.tuile_y*0.6));
        barre_graph.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
        lp_barre_graph.gravity=Gravity.TOP;
        barre_graph.setLayoutParams(lp_barre_graph);
        graphiques.addView(barre_graph);

        TextView text_graph = new TextView(getApplicationContext());
        text_graph.setText("Graphiques");
        text_graph.setTextColor(getResources().getColor(R.color.colorPrimary));
        text_graph.setTextSize(20);
        FrameLayout.LayoutParams lp_text_graph = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_text_graph.gravity = Gravity.LEFT|Gravity.CENTER_VERTICAL;
        lp_text_graph.setMargins(Static.screen_x/100,0,0,0);
        text_graph.setLayoutParams(lp_text_graph);
        barre_graph.addView(text_graph); 








        edit_info.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                final Intent intent = new Intent(FocusedCatTile.this, FocusedCatTile.class);
                intent.putExtra("id_cat", id_chat);
                intent.putExtra("last_page", last_page);
                if(mode==0){
                    intent.putExtra("mode",1);
                    startActivity(intent);
                }
                else{
                    intent.putExtra("mode",0);
                    FeedKatAPI.getInstance(null).ModifyCat(cat.c_id, name.getText().toString(), getEnglishDate(ebirth.getText().toString()), picture, new Response.Listener<JSONObject>() {
                        @Override
                        public void onResponse(JSONObject response) {
                            Log.v("ReturnModify", "on Succuess");
                            cat.c_name= name.getText().toString();
                            cat.c_date_naissance = getEnglishDate(ebirth.getText().toString());
//                            ListeChat.getList().get(id_chat).c_name = cat.c_name;
//                            ListeChat.getList().get(id_chat).c_date_naissance = cat.c_date_naissance;
                            if(picture != null) cat.tmp_photo = picture;
                            startActivity(intent);
                        }
                    }, new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error)
                        {
                            Log.v("ReturnModify", "on error");
                            cat.c_name= name.getText().toString();
                            cat.c_date_naissance = getEnglishDate(ebirth.getText().toString());
                            if(picture != null) cat.tmp_photo = picture;
                            startActivity(intent);
                        }
                    });
                }

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

    public String getEnglishDate(String date){
        String EnglishDate,jour,mois,annee;
        jour = date.substring(0,2);
        mois = date.substring(3,5);
        annee = date.substring(6,10);
        EnglishDate = annee + "-" + mois + "-" + jour;
        return EnglishDate;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == RESULT_LOAD_IMAGE && resultCode == RESULT_OK && null != data) {
            Uri selectedImage = data.getData();
            String[] filePathColumn = { MediaStore.Images.Media.DATA };
            Cursor cursor = getContentResolver().query(selectedImage,filePathColumn, null, null, null);
            cursor.moveToFirst();
            int columnIndex = cursor.getColumnIndex(filePathColumn[0]);
            String picturePath = cursor.getString(columnIndex);
            cursor.close();
            picture = Static.convertProfileImage(BitmapFactory.decodeFile(picturePath));
            photo_cat.setImageBitmap(Static.getProfileImage(this, picture));
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        switch (requestCode) {
            case MY_PERMISSIONS_REQUEST_READ_STORAGE: {
                // If request is cancelled, the result arrays are empty.
                if (grantResults.length > 0
                        && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
//                    edit.setColorFilter(Color.TRANSPARENT);
                } else {

//                    Toast.makeText(MyAccountActivity.this, getResources().getString(R.string.toast_no_permission), Toast.LENGTH_LONG).show();
                }
                return;
            }

            // other 'case' lines to check for other
            // permissions this app might request
        }
    }


    public static class TimePickerFragment extends DialogFragment
            implements TimePickerDialog.OnTimeSetListener {

        @Override
        public Dialog onCreateDialog(Bundle savedInstanceState) {
            // Use the current time as the default values for the picker
            final Calendar c = Calendar.getInstance();
            int hour = c.get(Calendar.HOUR_OF_DAY);
            int minute = c.get(Calendar.MINUTE);

            // Create a new instance of TimePickerDialog and return it
            return new TimePickerDialog(getActivity(), this, hour, minute,
                    DateFormat.is24HourFormat(getActivity()));
        }

        public void onTimeSet(TimePicker view, int hourOfDay, int minute) {
            // Do something with the time chosen by the user
            etime.setText(hourOfDay+":"+minute+":00");
        }
    }


    public static class DatePickerFragment extends DialogFragment
            implements DatePickerDialog.OnDateSetListener {

        @Override
        public Dialog onCreateDialog(Bundle savedInstanceState) {
            // Use the current date as the default date in the picker
            final Calendar c = Calendar.getInstance();
            int year = c.get(Calendar.YEAR);
            int month = c.get(Calendar.MONTH);
            int day = c.get(Calendar.DAY_OF_MONTH);

            // Create a new instance of DatePickerDialog and return it
            return new DatePickerDialog(getActivity(), this, year, month, day);
        }

        public void onDateSet(DatePicker view, int year, int month, int day) {
            String newday;
            if(day < 10 ){
                newday = "0"+day;
            }
            else{
                newday = ""+day;
            }
            if(month < 10 ){
                ebirth.setText(newday + "-0" + (month +1) + "-" + year);
            }
            else{
                ebirth.setText(newday + "-" + (month +1) + "-" + year);
            }


        }
    }

    // return true si une caméra est présente
    private boolean testPresenceCamera() {
        PackageManager packageManager = getPackageManager();
        return packageManager.hasSystemFeature(PackageManager.FEATURE_CAMERA);
    }
}



