<?php 

public function makepdf(){
        //define('FPDF_FONTPATH','system/library/fpdf/fonts/');
        require_once('system/library/fpdf/fpdf.php');
        $pdf = new FPDF();
        echo "|ok";
        /*
        $pdf->AddPage();
        $pdf->SetFont('Arial','B',16);
        $pdf->Cell(40,10,'Hello World!');
        */
        //$pdf->Output();
    } 
?>
