unit uUART;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmUART = class(TForm)
    edUART: TEdit;
    Label1: TLabel;
    edUARTTune: TEdit;
    Label2: TLabel;
    chMainenable: TCheckBox;
    chScndenable: TCheckBox;
    chTrainenable: TCheckBox;
    chLocalenable: TCheckBox;
    chUARTDebug: TCheckBox;
    Label3: TLabel;
    chUART: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uMain;

{$R *.dfm}

procedure TfrmUART.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : Integer;
begin
  if Length(edUART.Text) = 0 then // nie skracac warunku- wpis nie oznacza zalaczenia
    chUART.Checked := False;

  if not chUART.Checked then
    Main.Settings.UART := edUART.Text
  else
  begin
    Main.Settings.UART := EmptyStr;
    Main.Settings.FindParameter('uart','komunikacja uart');
  end;

  i := 0;
  while i <= Main.Settings.Params.Count-1 do
  begin
    if Main.Settings.Params[i].Name = 'uart' then
    begin
      if chUART.Checked then
        Main.Settings.Params[i].Value := edUART.Text
      else
      begin
        Main.Settings.Params.Remove(Main.Settings.Params[i]);
        Continue;
      end;
    end
    else
    if Main.Settings.Params[i].Name = 'uarttune' then
      Main.Settings.Params[i].Value := edUARTtune.Text
    else
    if Main.Settings.Params[i].Name = 'uartdebug' then
    begin
      if chUARTDebug.Checked then
        Main.Settings.Params[i].Value := 'yes'
      else
        Main.Settings.Params[i].Value := 'no';
    end
    else
      if Main.Settings.Params[i].Name = 'uartfeature' then
      begin
        if chMainenable.Checked then
          Main.Settings.Params[i].Value := 'yes'
        else
          Main.Settings.Params[i].Value := 'no';

        if chScndenable.Checked then
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' yes'
        else
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' no';

        if chTrainenable.Checked then
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' yes'
        else
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' no';

        if chLocalenable.Checked then
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' yes'
        else
          Main.Settings.Params[i].Value := Main.Settings.Params[i].Value +  ' no';
      end;
    Inc(i);
  end;
end;

procedure TfrmUART.FormCreate(Sender: TObject);
var
  i : Integer;
  Par : TStringList;
begin
  if Main.Settings.UART.Length > 0 then
  begin
    chUART.Checked := False;
    edUART.Text := Main.Settings.UART;
  end;

  for i := 0 to Main.Settings.Params.Count-1 do
  begin
    if Main.Settings.Params[i].Name = 'uart' then
    begin
      chUART.Checked := True;
      edUART.Text := Main.Settings.Params[i].Value;
    end
    else
    if Main.Settings.Params[i].Name = 'uarttune' then
      edUARTtune.Text := Main.Settings.Params[i].Value
    else
    if Main.Settings.Params[i].Name = 'uartdebug' then
      chUARTDebug.Checked := Main.Settings.Params[i].Value = 'yes'
    else
    if Main.Settings.Params[i].Name = 'uartfeature' then
    begin
      Par := TStringList.Create;
      ExtractStrings([' '],[],PChar(Main.Settings.Params[i].Value),Par);
      chMainenable.Checked   := Par[0] = 'yes';
      chScndenable.Checked   := Par[1] = 'yes';
      chTrainenable.Checked  := Par[2] = 'yes';
      chLocalenable.Checked  := Par[3] = 'yes';
      Par.Free;
    end;
  end;
end;

end.
