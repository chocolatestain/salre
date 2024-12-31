package com.salre.main.contract;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

public class ImageConverter {
	public static void convertPdfToImage(String pdfPath, String imagePath) throws Exception {
       
		System.out.println("ImageConverter pdfPath:" +pdfPath );
		System.out.println("ImageConverter imagePath:" +imagePath );
		try (PDDocument pdfDocument =Loader.loadPDF(new File(pdfPath))) {
            PDFRenderer renderer = new PDFRenderer(pdfDocument);
            BufferedImage image = renderer.renderImageWithDPI(0, 300); // 첫 번째 페이지, 300 DPI

            ImageIO.write(image, "png", new File(imagePath));
        }
    }
}
