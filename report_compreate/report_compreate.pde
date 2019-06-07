import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;


Minim minim;
Oscil osc1, osc2;    // 音声のオブジェクト
BandPass bpf1, bpf2; // バンドパスフィルタのオブジェクト
AudioOutput out;     // 音声を出力するオブジェクト
AudioRecorder rec;   // 音声をファイルへ書き出すオブジェクト
FFT fft;             // スペクトルを計算するオブジェクト
boolean graphMode = true;
float f0 = 0;  // 基音の周波数
float a1 =0;  // 音源1の振幅
float a2 = 0;  // 音源2の振幅
float f1 = 0;  // フィルタ1の中心周波数
float f2 = 0;  // フィルタ2の中心周波数
float bw1 =10;// フィルタ1の帯域幅
float bw2 = 1;// フィルタ2の帯域幅
final float sampleRate = 44100;      // 標本化周波数
final String filename = "vowel.wav"; // 出力するファイルの名前


void setup()
{
  size(1024, 256);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  osc1 = new Oscil(f0, a1, Waves.SAW); // 音源1を生成する
  osc2 = new Oscil(f0, a2, Waves.SAW); // 音源2を生成する
  bpf1 = new BandPass(f1, bw1, sampleRate); // フィルタ1を生成する
  bpf2 = new BandPass(f2, bw2, sampleRate);                                // フィルタ2を生成する
  osc1.patch(bpf1).patch(out); // 音源1をフィルタ1を通してoutへ接続する
  osc2.patch(bpf2).patch(out); // 音源2をフィルタ2を通してoutへ接続する
  fft = new FFT(out.bufferSize(), out.sampleRate()); // スペクトルを計算するオブジェクト
  rec = minim.createRecorder(out, filename); // ファイルへ出力するオブジェクト
  
}

void keyTyped() {
  switch (key) {
    case 'r': if (!rec.isRecording()) { 
                rec.beginRecord();  // ファイル出力を開始する
              } else {
                rec.endRecord();    // ファイル出力を停止する
              }
              break;
    case 'w': graphMode = true; break; // 音声波形を表示する
    case 's': graphMode = false; break; // スペクトルを表示する
    case 'a':
    minim.stop();
    f0 = 119;  // 基音の周波数
    a1 =1;  // 音源1の振幅
    a2 = 0.014125375446228;  // 音源2の振幅
    f1 = 736;  // フィルタ1の中心周波数
    f2 = 3438;  // フィルタ2の中心周波数
    
      size(1024, 256);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  osc1 = new Oscil(f0, a1, Waves.SAW); // 音源1を生成する
  osc2 = new Oscil(f0, a2, Waves.SAW); // 音源2を生成する
  bpf1 = new BandPass(f1, bw1, sampleRate); // フィルタ1を生成する
  bpf2 = new BandPass(f2, bw2, sampleRate);                                // フィルタ2を生成する
  osc1.patch(bpf1).patch(out); // 音源1をフィルタ1を通してoutへ接続する
  osc2.patch(bpf2).patch(out); // 音源2をフィルタ2を通してoutへ接続する
  fft = new FFT(out.bufferSize(), out.sampleRate()); // スペクトルを計算するオブジェクト
  rec = minim.createRecorder(out, filename); // ファイルへ出力するオブジェクト
              break;
    case 'i':
    minim.stop();
    f0 = 128;  // 基音の周波数
    a1 =1;  // 音源1の振幅
    a2 = 0.036728230049808;  // 音源2の振幅
    f1 = 246;  // フィルタ1の中心周波数
    f2 = 2440;  // フィルタ2の中心周波数
              
     size(1024, 256);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  osc1 = new Oscil(f0, a1, Waves.SAW); // 音源1を生成する
  osc2 = new Oscil(f0, a2, Waves.SAW); // 音源2を生成する
  bpf1 = new BandPass(f1, bw1, sampleRate); // フィルタ1を生成する
  bpf2 = new BandPass(f2, bw2, sampleRate);                                // フィルタ2を生成する
  osc1.patch(bpf1).patch(out); // 音源1をフィルタ1を通してoutへ接続する
  osc2.patch(bpf2).patch(out); // 音源2をフィルタ2を通してoutへ接続する
  fft = new FFT(out.bufferSize(), out.sampleRate()); // スペクトルを計算するオブジェクト
  rec = minim.createRecorder(out, filename); // ファイルへ出力するオブジェクト
  break;
    case 'o':
    minim.stop();
    f0 = 123;  // 基音の周波数
    a1 =1;  // 音源1の振幅
    a2 = 0.017782794100389;  // 音源2の振幅
    f1 = 367;  // フィルタ1の中心周波数
    f2 = 2722;  // フィルタ2の中心周波数
    
     size(1024, 256);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.MONO);
  osc1 = new Oscil(f0, a1, Waves.SAW); // 音源1を生成する
  osc2 = new Oscil(f0, a2, Waves.SAW); // 音源2を生成する
  bpf1 = new BandPass(f1, bw1, sampleRate); // フィルタ1を生成する
  bpf2 = new BandPass(f2, bw2, sampleRate);                                // フィルタ2を生成する
  osc1.patch(bpf1).patch(out); // 音源1をフィルタ1を通してoutへ接続する
  osc2.patch(bpf2).patch(out); // 音源2をフィルタ2を通してoutへ接続する
  fft = new FFT(out.bufferSize(), out.sampleRate()); // スペクトルを計算するオブジェクト
  rec = minim.createRecorder(out, filename); // ファイルへ出力するオブジェクト
                break;
                
                
 
  }
}

void draw()
{
  
    
  background(0); noFill(); stroke(255);
  fft.forward(out.mix);

  // 音声出力のバッファに入っている波形を描画する
  beginShape();
  if (graphMode) { // 波形を表示
    stroke(255, 255, 0);
    for (int i = 0; i < out.bufferSize(); i++) {
      float x = map(i, 0, out.bufferSize(), 0, width);
      vertex(x, height * 0.5 + out.mix.get(i) * height * 0.5);
    }
  } else { // スペクトルを対数軸で表示
    stroke(0, 255, 255);
    for (int i = 0; i < fft.specSize() / 2; i++) { // 
      float x = map(i, 0, fft.specSize(), 0, width * 2.0);
      vertex(x, height - log(1 + fft.getBand(i)) * height / 6.0);
    }
  }
  endShape();
  noStroke(); fill(255, 0, 0);
  if (rec.isRecording()) { ellipse(8, 8, 10, 10); } 
}
