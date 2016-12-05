package polytech.feedkat;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.TextView;

import com.android.volley.Response;

/**
 * Created by olivierlafon on 21/10/2016.
 */

public class Popup extends FrameLayout{

    public Popup(Context context, String message, final Response.Listener click)
    {
        super(context);
        setBackgroundColor(Color.parseColor("#88000000"));
        FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        setLayoutParams(lp);

        FrameLayout body = new FrameLayout(context);
        FrameLayout.LayoutParams lp_body = new FrameLayout.LayoutParams(Static.screen_x,Static.screen_y/2);
        lp_body.gravity = Gravity.CENTER;
        body.setBackgroundColor(Color.WHITE);
        body.setLayoutParams(lp_body);

        TextView text = new TextView(context);
        text.setText(message);
        text.setTextSize(20);
        text.setTextColor(Color.BLACK);
        FrameLayout.LayoutParams lp_text = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_text.gravity = Gravity.CENTER;
        text.setLayoutParams(lp_text);

        body.addView(text);

        Button button = new Button(context);
        button.setText("OK");
        button.setTextColor(getResources().getColor(R.color.colorPrimaryDark));
        button.setBackgroundColor(Color.WHITE);
        FrameLayout.LayoutParams lp_button = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        lp_button.gravity = Gravity.RIGHT | Gravity.BOTTOM;
        button.setLayoutParams(lp_button);

        body.addView(button);
        addView(body);

        button.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                click.onResponse(null);
            }
        });

    }
}
