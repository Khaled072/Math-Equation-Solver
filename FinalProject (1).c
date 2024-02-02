#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>


int Linear(int *rounds,int *player1,int *player2) {
    int rA;
    srand(time(NULL));
        rA = (rand()%20)+1;
        printf("x-%d=0",rA);
        printf("\nPlayer1: Enter solution");
        int s;
        scanf("%d",&s);
        if(s==rA) {
             printf("success!!\n");
            *player1+=1;
        }
        else {
             printf("wrong!!!\n");
        }
        printf("Player2 turn:\n");
        srand(time(NULL));
        rA = (rand()%20)+1;
        printf("x-%d=0",rA);
        printf("\nPlayer2: Enter solution");
        scanf("%d",&s);
        if(s==rA) {
             printf("success!!\n");
            *player2+=1;
        }
        else {
             printf("wrong!!!\n");
        }
        *rounds+=1;
        return *rounds;
}

int quadratic1(int *rounds,int *player1,int *player2) {
     int rA;
     int rB;
     int mid;
     int c;
     int x1;
     int x2;
    printf("ROUND 2!!\n");
    //random number generator for the constants of the equation
    srand(time(NULL));
    rA = (rand()%9)+1;
    rB = (rand()%9)+1;
    mid = (rA+rB); //b value in the quadratic function
    c = rA*rB;//c value in the quadratic function
    printf("(x^2)-%dx+%d=0",mid,c);
    //player guess
    printf("\nPlayer1: Enter x1 and x2:");
    scanf("%d",&x1);
    scanf("%d",&x2);
    //checking the player's answer
    if(((x1 == rA)&&(x2==rB))||((x1 == rB)&&(x2==rA))) {
        printf("success!!\n");
        *player1+=1;
    }
    else {
        printf("wrong!!!\n");
    }
    printf("Player2 turn:\n");
    srand(time(NULL));
    rA = (rand()%9)+1;
    rB = (rand()%9)+1;
    mid = (rA+rB); //b value in the quadratic function
    c = rA*rB;//c value in the quadratic function
    printf("(x^2)-%dx+%d=0",mid,c);
    printf("\nEnter x1 and x2:");
    scanf("%d",&x1);
    scanf("%d",&x2);
    //checking the player's answer
    if(((x1 == rA)&&(x2==rB))||((x1 == rB)&&(x2==rA))) {
        printf("success!!\n");
        *player2+=1;
    }
    else {
        printf("wrong!!!\n");
    }
    *rounds+=1;
    return *rounds;
}

int quadratic2(int *rounds,int *player1,int *player2) {
     int rA;
     int rB;
     int mid;
     int c;
     int x1;
     int x2;
     printf("ROUND 3!!\n");
        srand(time(NULL));
        rA = (rand()%15)+1;
        rB = (rand()%15)+1;
        mid = (rA+rB); //b value in the quadratic function
        c = rA*rB;//c value in the quadratic function
        printf("(x^2)-%dx+%d=0",mid,c);
    //player guess
        printf("\nPlayer1: Enter x1 and x2:");
        scanf("%d",&x1);
        scanf("%d",&x2);
    //checking the player's answer
    if(((x1 == rA)&&(x2==rB))||((x1 == rB)&&(x2==rA))) {
        printf("success!!\n");
        *player1+=1;
    }
    else {
        printf("wrong!!!\n");
    }
    printf("Player2 turn:\n");
    srand(time(NULL));
    rA = (rand()%15)+1;
    rB = (rand()%15)+1;
    mid = (rA+rB); //b value in the quadratic function
    c = rA*rB;//c value in the quadratic function
    printf("(x^2)-%dx+%d=0",mid,c);
    printf("\nEnter x1 and x2:");
    scanf("%d",&x1);
    scanf("%d",&x2);
    //checking the player's answer
    if(((x1 == rA)&&(x2==rB))||((x1 == rB)&&(x2==rA))) {
        printf("success!!\n");
        *player2+=1;
    }
    else {
        printf("wrong!!!\n");
    }
    *rounds+=1;
    return *rounds;
}

int cubic(int *rounds, int *player1, int *player2) {
    int rA;
     int rB;
     int mid;
     int c;
     int x1;
     int x2;
     int rC;
     int x3;
    printf("ROUND 4!!\n");
        srand(time(NULL));
         rA = (rand()%9)+1;
         rB = (rand()%9)+1;
         rC = (rand()%9)+1;
         int B = rA+rB+rC;
         int C = (rA*rB)+(rB*rC)+(rC*rA);
         int D = (rA*rB*rC);
        printf("(x^3)-%d(x^2)+%dx-%d=0",B,C,D);
        printf("\nPlayer1: Enter x1,x2, and x3:");
        scanf("%d",&x1);
        scanf("%d",&x2);
        scanf("%d",&x3);
        if(((x1 == rA)&&(x2==rB)&&(x3==rC))|| ((x1 == rB)&&(x2==rA)&&(x3==rC)) || ((x1 == rC)&&(x2==rA)&&(x3==rB))|| ((x1 == rB)&&(x2==rC)&&(x3==rA)) || ((x1 == rA)&&(x2==rC)&&(x3==rB))  || ((x1 == rC)&&(x2==rB)&&(x3==rA))) {
        printf("success!!\n");
        *player1+=1;
        }
        else {
        printf("wrong!!!\n");
        }
            printf("Player2 turn:\n");
            srand(time(NULL));
             rA = (rand()%9)+1;
             rB = (rand()%9)+1;
             rC = (rand()%9)+1;
             B = rA+rB+rC;
             C = (rA*rB)+(rB*rC)+(rC*rA);
             D = (rA*rB*rC);
            printf("(x^3)-%d(x^2)+%dx-%d=0",B,C,D);
            printf("\nPlayer2: Enter x1,x2, and x3:");
            scanf("%d",&x1);
            scanf("%d",&x2);
            scanf("%d",&x3);
            if(((x1 == rA)&&(x2==rB)&&(x3==rC))|| ((x1 == rB)&&(x2==rA)&&(x3==rC)) || ((x1 == rC)&&(x2==rA)&&(x3==rB))|| ((x1 == rB)&&(x2==rC)&&(x3==rA)) || ((x1 == rA)&&(x2==rC)&&(x3==rB))  || ((x1 == rC)&&(x2==rB)&&(x3==rA))) {
            printf("success!!\n");
            *player2+=1;
            }
            else {
            printf("wrong!!!\n");
            }
            *rounds+=1;
    return *rounds;

}

void bounusRound(int *player1, int *player2) {
printf("For this round I have an already implanted 2-D array with values\nThe player will enter two numbers which will pick two roots for the 2D array and if the player answers correctly he or she will receive 10 extra points");
int row;
int col;
int x1;
int x2;
int s1;
int s2;
int mid;
int c;

int roots[5][5] = {
    {1,2,3,4,5},
    {6,7,8,9,10},
    {11,12,13,14,15},
    {16,17,18,19,20},
    {21,22,23,24,25}
};

 printf("\nPlayer 1 Enter row and column for first root");
 scanf("%d",&row);
 scanf("%d",&col);

    for(int i =0; i < 5; ++i) {
    	for(int j = 0; j < 5; ++j) {
          if(i==row && j == col) {
            x1=roots[i][j];
            }
        }
    }
printf("Enter row and column for first second range between 0-4");
scanf("%d",&row);
scanf("%d",&col);

    for(int i =0; i < 5; ++i) {
    	for(int j = 0; j < 5; ++j) {
          if(i==row && j == col) {
            x2=roots[i][j];
            }
        }
    }

        mid = (x1+x2); //b value in the quadratic function
        c = x1*x2;//c value in the quadratic function
        printf("(x^2)-%dx+%d=0",mid,c);
    //player guess
        printf("\nPlayer1: Enter x1 and x2:");
        scanf("%d",&s1);
        scanf("%d",&s2);
    //checking the player's answer
    if(((s1 == x1)&&(s2==x2))||((s1 == x2)&&(s2==x1))) {
        printf("success!!\n");
        *player1+=1;
    }
    else {
        printf("wrong!!!\n");
    }
printf("Player2 turn:");
printf("\nEnter row and column for first root range between 0-4");
 scanf("%d",&row);
 scanf("%d",&col);

    for(int i =0; i < 5; ++i) {
    	for(int j = 0; j < 5; ++j) {
          if(i==row && j == col) {
            x1=roots[i][j];
            }
        }
    }
printf("\nPlayer 2 Enter row and column for first second");
scanf("%d",&row);
scanf("%d",&col);

    for(int i =0; i < 5; ++i) {
    	for(int j = 0; j < 5; ++j) {
          if(i==row && j == col) {
            x2=roots[i][j];
            }
        }
    }

        mid = (x1+x2); //b value in the quadratic function
        c = x1*x2;//c value in the quadratic function
        printf("(x^2)-%dx+%d=0",mid,c);
    //player guess
        printf("\nPlayer1: Enter x1 and x2:");
        scanf("%d",&s1);
        scanf("%d",&s2);
    //checking the player's answer
    if(((s1 == x1)&&(s2==x2))||((s1 == x2)&&(s2==x1))) {
        printf("success!!\n");
        *player1+=1;
    }
    else {
        printf("wrong!!!\n");
    }
}









int main()
{
    //game header
    printf("Welcome to Math Bee\n");
    printf("This game will test your math abilities to the limit\n");
    printf("You will be presented with an equation with only one guess oppurtunity\n");
    printf("Get ready the question is on the way!!!\n");
    printf("Round 1: Linear:\n");
    int player1=0; //players
    int player2=0;
    int rounds = 0;//game round

    Linear(&rounds, &player1, &player2);

    if(rounds==1) {
    quadratic1(&rounds, &player1, &player2);
    }

    if(rounds==2) {
        quadratic2(&rounds, &player1, &player2);
    }

    if(rounds==3) {
        cubic(&rounds, &player1, &player2);
    }
    if(rounds==4) {
        bounusRound(&player1, &player2);
    }

   if(player2>player1) {
     printf("player2 wins!!!\n");
        }
    else if (player1>player2){
      printf("player1 wins!!!\n");
    }
    else {
        printf("Draw!\n");
    }
}
