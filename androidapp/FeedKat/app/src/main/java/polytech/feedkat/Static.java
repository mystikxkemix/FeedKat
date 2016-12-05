package polytech.feedkat;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.view.Display;

import java.io.ByteArrayOutputStream;

/**
 * Created by olivierlafon on 05/10/2016.
 */
public class Static {
    public static int screen_x, screen_y, ecart_bordure, ecart_tuile, tuile_x, tuile_y;

    public static String convertProfileImage(Bitmap image)
    {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        image.compress(Bitmap.CompressFormat.JPEG, 50, baos);
        byte[] b = baos.toByteArray();

        return Base64.encodeToString(b, Base64.DEFAULT);
    }

    public static Bitmap getProfileImage(Context context, String image)
    {
        Bitmap res;
        if( !image.equalsIgnoreCase("") ){
            byte[] b = Base64.decode(image, Base64.DEFAULT);
            res = BitmapFactory.decodeByteArray(b, 0, b.length);
        }
        else
        {
            res = BitmapFactory.decodeResource(context.getResources(),
                    R.drawable.logo_feedkat_300px);
        }

        return res;
    }
}
