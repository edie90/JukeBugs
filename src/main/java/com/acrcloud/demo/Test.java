package com.acrcloud.demo;

/**
 *
 *  @author qinxue.pan E-mail: xue@acrcloud.com
 *  @version 1.0.0
 *  @create 2015.10.01
 *  
 **/

import java.io.*;
import java.util.Map;
import java.util.HashMap;

import com.acrcloud.utils.ACRCloudRecognizer;

public class Test {
	
	public String test(String fileName){
		
		System.out.println(fileName);
		
        Map<String, Object> config = new HashMap<String, Object>();
        config.put("host", "ap-southeast-1.api.acrcloud.com");
        // Replace "xxxxxxxx" below with your project's access_key and access_secret.
        config.put("access_key", "e55ab2e0061cf814bdd7951a9001ebf4");
        config.put("access_secret", "0yqQqdDM61WG416GPdVZPPayWZh5FS0Wz1x7cZMK");
        config.put("debug", false);
        config.put("timeout", 10); // seconds

        ACRCloudRecognizer re = new ACRCloudRecognizer(config);

        String result = re.recognizeByFile(fileName, 10);
        System.out.println(result);

        File file = new File(fileName);
        byte[] buffer = new byte[3 * 1024 * 1024];
        if (!file.exists()) {
            return null;
        }
        FileInputStream fin = null;
        int bufferLen = 0;
        try {
            fin = new FileInputStream(file);
            bufferLen = fin.read(buffer, 0, buffer.length);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fin != null) {
                	fin.close();
                }
            } catch (IOException e) {
            	e.printStackTrace();
            }
        }
        System.out.println("bufferLen=" + bufferLen);
        
        if (bufferLen <= 0)
            return null;

        // It will skip 80 seconds from the begginning of (buffer).
//        result = re.recognizeByFileBuffer(buffer, bufferLen, 80);
//        System.out.println(result);

        // recognize by wav audio buffer(RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 8000 Hz) 
        //File file = new File("test.wav");
        //byte[] buffer = new byte[12 * 8000 * 2];
        //if (!file.exists()) {
        //    return;
        //}
        //FileInputStream fin = null;
        //int bufferLen = 0;
        //try {
        //    fin = new FileInputStream(file);
        //    fin.skip(44);
        //    bufferLen = fin.read(buffer, 0, buffer.length);
        //} catch (Exception e) {
        //    e.printStackTrace();
        //} finally {
        //    try {
        //        if (fin != null) {
        //        	fin.close();
        //        }
        //    } catch (IOException e) {
        //    	e.printStackTrace();
        //    }
        //}
        //System.out.println("bufferLen=" + bufferLen);
        //
        //if (bufferLen <= 0)
        //    return;

        //String result = re.recognize(buffer, bufferLen);
        //System.out.println(result);
        return result;
	}

}
