unit UMOSetup;
{******************************************************************************
 *
 *  LCD Smartie - LCD control software.
 *  Copyright (C) 2000-2003  BassieP
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 *  $Source: /cvsroot/lcdsmartie/lcdsmartie/Attic/UMOSetup.pas,v $
 *  $Revision: 1.6 $ $Date: 2006/02/27 18:35:47 $
 *****************************************************************************}


interface

uses StdCtrls, ComCtrls, Classes, Controls, Forms;

type
  TMatrixOrbitalSetupForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox3: TGroupBox;
    GroupBox1: TGroupBox;
    MOUSBCheckbox: TCheckBox;
    ContrastTrackBar: TTrackBar;
    BrightnessTrackBar: TTrackBar;
    procedure ContrastTrackBarChange(Sender: TObject);
    procedure BrightnessTrackBarChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoMatrixOrbitalSetupForm : boolean;

implementation

uses USetup, UMain;

{$R *.DFM}

function DoMatrixOrbitalSetupForm : boolean;
var
  MatrixOrbitalSetupForm : TMatrixOrbitalSetupForm;
begin
  MatrixOrbitalSetupForm := TMatrixOrbitalSetupForm.Create(nil);
  with MatrixOrbitalSetupForm do begin
    // put settings on screen
    ContrastTrackBar.position := config.contrast;
    BrightnessTrackBar.position := config.brightness;
    MOUSBCheckbox.Checked := config.mx3Usb;
    ShowModal;
    Result := (ModalResult = mrOK);
    if Result then begin
      config.contrast := ContrastTrackBar.position;
      config.brightness := BrightnessTrackBar.position;
      config.mx3Usb := MOUSBCheckbox.Checked;
    end else begin
      if (config.isMO) then
      begin
        LCDSmartieDisplayForm.lcd.setContrast(config.contrast);
        LCDSmartieDisplayForm.lcd.setBrightness(config.brightness);
      end;
    end;
    Free;
  end;
end;

// MO options - contrast bar.
procedure TMatrixOrbitalSetupForm.ContrastTrackBarChange(Sender: TObject);
begin
  if (config.isMO) then
    LCDSmartieDisplayForm.lcd.setContrast(ContrastTrackBar.position);
end;

// MO options - brightness bar.
procedure TMatrixOrbitalSetupForm.BrightnessTrackBarChange(Sender: TObject);
begin
  if (config.isMO) then
    LCDSmartieDisplayForm.lcd.setBrightness(BrightnessTrackBar.position);
end;

end.
